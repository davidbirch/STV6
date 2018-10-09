class CreateScrapers < ActiveRecord::Migration[5.2]
  def change
    create_table :scrapers do |t|
      t.text :target_region_list
      t.float :days_to_gather
      t.string :requested_by
      
      t.integer :job_id 
      t.timestamps null: false
    end
  end
end
