class CreateBroadcastServices < ActiveRecord::Migration[5.0]
  def change
    create_table :broadcast_services do |t|
      t.integer :region_id
      t.integer :channel_id
      
      t.timestamps null: false
    end

    add_index :broadcast_services, :region_id
    add_index :broadcast_services, :channel_id
    add_index :broadcast_services, [:region_id, :channel_id], unique: true
  end
end
