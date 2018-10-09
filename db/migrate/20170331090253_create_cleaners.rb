class CreateCleaners < ActiveRecord::Migration[5.2]
  def change
    create_table :cleaners do |t|
      t.string :requested_by
      t.boolean :clean_raw_programs
      t.boolean :clean_raw_channels
      t.boolean :clean_broadcast_events
      t.boolean :clean_historic_broadcast_events
      t.boolean :clean_programs
      t.boolean :clean_broadcast_services
      t.boolean :clean_channels
      
      t.integer :job_id 
      t.timestamps null: false
    end
  end
end
