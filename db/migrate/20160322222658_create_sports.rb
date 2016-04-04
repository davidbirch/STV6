class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
      t.string :url_friendly_name

      t.timestamps null: false
    end
  end
end
