class Subscriber < User
  authenticates_with_sorcery!

  belongs_to :admin, class_name: 'Admin', foreign_key: 'user_id'
  validates_presence_of :phone, :country
end
