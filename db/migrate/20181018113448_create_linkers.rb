class CreateLinkers < ActiveRecord::Migration[5.2]
  def change
    create_table :linkers do |t|
      t.string :requested_by
      
      t.integer :job_id 
      t.timestamps null: false
    end
  end
end
