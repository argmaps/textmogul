class Broadcast < ActiveRecord::Base
  belongs_to :user
  store_accessor :properties, :recurring_day
end
