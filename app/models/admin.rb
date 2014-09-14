class Admin < User
  authenticates_with_sorcery!

  has_many :subscribers, foreign_key: 'user_id', class_name: 'Subscriber'
  has_many :broadcasts

  validates_uniqueness_of :subdomain, case_sensitive: false, message:  'Please choose another subdomain.'
  validates_presence_of :subdomain, :stripe_secret_key, :stripe_publishable_key
end
