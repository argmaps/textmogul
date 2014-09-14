class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.string :stripe_id
      t.decimal :price
      t.string :interval

      t.timestamps
    end
    add_index :plans, :stripe_id, unique: true
  end
end
