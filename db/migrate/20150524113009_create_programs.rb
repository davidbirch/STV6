class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :title
      t.string :subtitle
      t.text :description
      t.text :program_hash
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.string :start_date_display
      t.string :local_start_date_display
      t.integer :region_id
      t.integer :channel_id
      t.integer :sport_id
      t.integer :keyword_id
      t.integer :category_id
    
      t.timestamps null: false
    end
    
    add_index :programs, :region_id
    add_index :programs, :sport_id
    add_index :programs, :channel_id
    add_index :programs, :keyword_id
    add_index :programs, :category_id
    
  end
end
