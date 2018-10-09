class CreateBroadcastEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :broadcast_events do |t|
      t.integer :program_id
      t.integer :broadcast_service_id
      t.text :broadcast_event_hash
      t.integer :epoch_scheduled_date, :limit => 8
      t.string :formatted_local_start_date
      t.datetime :formatted_scheduled_date
      t.datetime :formatted_end_date
      
      t.timestamps null: false
    end

    add_index :broadcast_events, :program_id
    add_index :broadcast_events, :broadcast_service_id
    add_index :broadcast_events, :epoch_scheduled_date
    add_index :broadcast_events, [:program_id, :broadcast_service_id, :epoch_scheduled_date], unique: true, name: 'be custom index'
  end
end
