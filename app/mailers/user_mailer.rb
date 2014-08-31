class UserMailer < ActionMailer::Base
  layout 'mailer'
  default from: "textmogul <support@textmogul.io>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def welcome_email(user)
    @subject = "Welcome to TextMogul"
    @user = user
    @support_email = 'support@textmogul.io'
    mail(to: user.email, subject: @subject) do |format|
      format.html
      format.text
    end
  end

  def reset_password_email(user)
    @subject = "Reset your password"
    @user = user
    @url = password_resets_url.concat("/#{user.reset_password_token}/edit")
    mail(to: user.email, subject: @subject) do |format|
      format.html
      format.text
    end
  end

  def alert_support_email(account)
    @subject = "New signup"
    @account = account
    @user = @account.users.first

    mail(to: 'support@textmogul.io', subject: @subject) do |format|
      format.html
      format.text
    end
  end
end
