class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|     
      t.string :title
      t.string :episode_title
      t.integer :keyword_id
      t.integer :duration
      t.boolean :black_flag

      t.timestamps null: false
    end
  end
end
