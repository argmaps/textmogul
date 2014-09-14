source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '4.1.5'
gem 'pg', '0.17.1'
gem 'activerecord-postgresql-adapter', '0.0.1'
gem 'simple_form', '3.1.0.rc2'
gem 'sorcery', '0.8.5'
gem 'request_store', '1.0.5'
gem 'gibbon', '1.1.2'
gem 'high_voltage'
gem 'stripe', '1.15.0'
gem 'mail_form'
gem 'switch_user'
gem 'countries', '0.9.2'
gem 'country_select', '1.2.0'
gem 'twilio-ruby'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'turboboost'

# keep sass-rails and bootstrap-sass out of assets group; otherwise @import 'bootstrap'; fails
gem 'sass-rails'
gem 'compass-rails'
gem 'rails-sass-images' # helpers for css, like: `inline('my.png')`
gem 'uglifier'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller' # for using better_errors advanced features (incl REPL)
  gem 'letter_opener'
  gem 'mail_view', '1.0.3' # for viewing emails at http://localhost:3000/mail_view/
  gem 'whitelist_mail_proxy', '0.5.0' # only send test e-mails to whitelisted domains
end

group :development, :test do
  gem 'dotenv-rails'
  # Debugging gems - must be excluded from Heroku
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
  gem 'pry-remote'

  gem 'factory_girl_rails' # needs to be included in dev group so Rails generators make factories instead of fixtures
end

group :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'vcr'
  gem 'webmock', '1.8'
end

group :production do
  gem 'puma'
  gem 'rack-timeout'
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end
