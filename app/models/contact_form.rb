class ContactForm < MailForm::Base
  append :remote_ip, :user_agent, :session

  attributes :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :message, validate: true
  attributes :nickname, captcha: true

  def headers
    {
      :subject => "Contact Us",
      :to => "support@textmogul.io",
      :from => "#{email}"
    }
  end
end
