class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.references :user, index: true
      t.timestamps
    end
  end
end
