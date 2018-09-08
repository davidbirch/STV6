class CreateMigrators < ActiveRecord::Migration[5.0]
  def change
    create_table :migrators do |t|
      t.text :target_region_list
      t.string :requested_by
      
      t.integer :job_id 
      t.timestamps null: false
    end
  end
end
