class CreateChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :channels do |t|
      t.text :channel_hash
      t.string :name
      t.string :url_friendly_name
      t.string :short_name
      t.string :tag
      t.string :url_friendly_short_name
      t.string :default_sport
      t.integer :provider_id
      t.boolean :black_flag
      
      t.timestamps null: false
    end
  end
end
