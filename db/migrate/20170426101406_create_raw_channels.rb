class CreateRawChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :raw_channels do |t|
      t.text :channel_hash
      t.string :channel_name
      t.string :channel_tag
      t.string :region_lookup
      t.string :region_name
            
      t.timestamps null: false
    end
  end
end
