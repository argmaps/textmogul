class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :stripe_id, null: false
      t.references :plan, index: true
      t.references :user, index: true
      t.integer :last_four, null: false
      t.string :card_type, null: false
      t.integer :expiration_month, null: false
      t.integer :expiration_year, null: false

      t.timestamps
    end
  end
end
