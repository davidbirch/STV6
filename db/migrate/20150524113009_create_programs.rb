class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :title
      t.string :subtitle
      t.string :category
      t.string :description
      t.datetime :start_datetime
      t.string :start_date_display
      t.datetime :end_datetime
      t.integer :region_id
      t.integer :channel_id
      t.integer :sport_id

      t.timestamps null: false
    end
    
    add_index :programs, :region_id
    add_index :programs, :sport_id
    add_index :programs, :channel_id
  end
end
