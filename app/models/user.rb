class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one :subscription
  has_one :plan, through: :subscription

  validates_presence_of :email, :password, :first_name, :last_name
  validates_length_of :password, minimum: 6, message: "Must be at least 6 characters long.", on: :create
  validates :email, :format => /@/
  validates_uniqueness_of :email, case_sensitive: false, message:  'Please choose another e-mail address.'

  before_save :downcase_email, if: Proc.new {|user| user.email_changed? }

  accepts_nested_attributes_for :subscription

  def self.current
    RequestStore.store[:user]
  end

  def self.current=(user)
    RequestStore.store[:user] = user
  end

  def super_user?
    email == 'josh@textmogul.io'
  end

  def downcase_email
    self.email = self.email.downcase
  end

  def country_code
    c = Country.find_country_by_alpha2(country)
    c.country_code
  end

  def full_phone
    user.country_code.to_s + phone.to_s
  end
end
