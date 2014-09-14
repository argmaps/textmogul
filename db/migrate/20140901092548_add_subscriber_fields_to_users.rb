class AddSubscriberFieldsToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :user, index: true
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :phone, :integer
    add_column :users, :type, :string, default: 'Subscriber'
  end
end
