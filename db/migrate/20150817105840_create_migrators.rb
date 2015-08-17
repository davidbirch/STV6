class CreateMigrators < ActiveRecord::Migration
  def change
    create_table :migrators do |t|
      t.text :target_region_list
      t.text :log
      t.string :status

      t.timestamps null: false
    end
  end
end
