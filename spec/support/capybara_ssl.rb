# run Capybara over https / ssl
require 'webrick/https'
require 'rack/handler/webrick'

def run_ssl_server(app, port)
  opts = {
    :Port => port,
    :SSLEnable => true,
    :SSLVerifyClient => OpenSSL::SSL::VERIFY_NONE,
    :SSLPrivateKey => OpenSSL::PKey::RSA.new(File.read "./ssl/dev/server.key"),
    :SSLCertificate => OpenSSL::X509::Certificate.new(File.read "./ssl/dev/server.crt"),
    :SSLCertName => [["US", 'localhost']],
    :AccessLog => [],
    :Logger => WEBrick::Log::new(Rails.root.join("./log/capybara_test.log").to_s)
  }

  Rack::Handler::WEBrick.run(app, opts)
end

Capybara.server do |app, port|
  run_ssl_server(app, port)
end

Capybara.server_port = 3001
Capybara.app_host = "https://localhost:%d" % Capybara.server_port

Capybara.register_driver :webkit do |app|
  driver = Capybara::Webkit::Driver.new(app)
  driver.browser.ignore_ssl_errors
  driver
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
    timeout: 60,
    phantomjs_options: ['--ignore-ssl-errors=yes', '--local-to-remote-url-access=yes']
  })
end

Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.secure_ssl = false
  profile.assume_untrusted_certificate_issuer = false
  Capybara::Selenium::Driver.new(app, :browser => :firefox, profile: profile)
end

module Capybara
  class Server
    def responsive?
      return false if @server_thread && @server_thread.join(0)

      http = Net::HTTP.new(host, @port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      res = http.get('/__identify__')

      if res.is_a?(Net::HTTPSuccess) or res.is_a?(Net::HTTPRedirection)
        return res.body == @app.object_id.to_s
      end
    rescue SystemCallError
      return false
    end
  end
end
