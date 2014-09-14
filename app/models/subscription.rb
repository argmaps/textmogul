class Subscription < ActiveRecord::Base
  belongs_to :plan
  has_one :user
end
