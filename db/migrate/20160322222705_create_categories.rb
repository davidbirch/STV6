class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :url_friendly_name
      t.boolean :black_flag

      t.timestamps null: false
    end
  end
end
