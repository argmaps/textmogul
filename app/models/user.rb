class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_presence_of :email, :password, :subdomain, :stripe_secret_key, :stripe_publishable_key, on: :create
  validates_length_of :password, minimum: 6, message: "Must be at least 6 characters long.", on: :create
  validates :email, :format => /@/
  validates_uniqueness_of :email, case_sensitive: false, message:  'Please choose another e-mail address.'
  validates_uniqueness_of :subdomain, case_sensitive: false, message:  'Please choose another subdomain.'

  before_save :downcase_email, if: Proc.new {|user| user.email_changed? }

  def self.current
    RequestStore.store[:user]
  end

  def self.current=(user)
    RequestStore.store[:user] = user
  end

  def admin?
    email == 'josh@textmogul.io'
  end

private
  def downcase_email
    self.email = self.email.downcase
  end
end
