class CreateRawPrograms < ActiveRecord::Migration
  def change
    create_table :raw_programs do |t|
      t.text :program_hash
      t.string :title
      t.string :subtitle
      t.string :category
      t.text :description
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.string :region_name
      t.string :channel_name
      t.string :channel_free_or_pay
      
      t.timestamps null: false
    end
  end
end
