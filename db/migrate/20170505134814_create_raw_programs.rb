class CreateRawPrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :raw_programs do |t|
      t.text :program_hash
      t.string :channel_tag
      t.string :region_lookup
      t.string :region_name
      t.boolean :placeholder
      t.string :title
      t.string :event_lookup      
            
      t.timestamps null: false
    end
  end
end
