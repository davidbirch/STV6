class CreateRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :regions do |t|
      t.string :name
      t.string :time_zone_name
      t.string :url_friendly_name
      t.string :region_lookup
      t.boolean :black_flag
      
      t.timestamps null: false  
    end
  end
end
