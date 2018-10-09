class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :url_friendly_name
      t.string :service_tier
      
      
      t.timestamps null: false
    end
  end
end
