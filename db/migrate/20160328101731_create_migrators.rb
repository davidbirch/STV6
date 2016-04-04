class CreateMigrators < ActiveRecord::Migration
  def change
    create_table :migrators do |t|
      t.text :target_region_list
      t.text :log
      t.string :status
      t.string :requested_by
      t.datetime :requested_at
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps null: false
    end
  end
end
