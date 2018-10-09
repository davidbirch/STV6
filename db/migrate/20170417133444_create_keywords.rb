class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.string :value
      t.string :url_friendly_value
      t.integer :sport_id
      t.integer :priority
      t.boolean :black_flag

      t.timestamps null: false
    end
  end
end
