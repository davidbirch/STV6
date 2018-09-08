class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.text :log
      t.string :status
      t.string :requested_by
      t.datetime :requested_at
      t.datetime :started_at
      t.datetime :completed_at
      
      t.integer :detail_id # the foreign key for a polymorphic relationship
      t.string  :detail_type
      t.timestamps null: false
    end
  end
end
