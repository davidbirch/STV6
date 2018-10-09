class CreateSports < ActiveRecord::Migration[5.2]
  def change
    create_table :sports do |t|
      t.string :name
      t.string :url_friendly_name
      t.boolean :black_flag

      t.timestamps null: false
    end
  end
end
