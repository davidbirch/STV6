class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :value
      t.integer :sport_id
      t.integer :priority

      t.timestamps null: false
    end
  end
end
