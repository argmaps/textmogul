if Rails.env.development?
  class MailPreview < MailView
    def welcome
      user = Struct.new(:email, :first_name).new('name@example.com', 'Ben')
      mail = UserMailer.welcome_email(user)
    end
    def reset_password
      user = Struct.new(:email, :reset_password_token).new('name@example.com', '23534twer324')
      mail = UserMailer.reset_password_email(user)
    end
  end
end
