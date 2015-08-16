class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.text :target_region_list
      t.text :log
      t.string :status
      t.float :days_to_gather

      t.timestamps null: false
    end
  end
end
