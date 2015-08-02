class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :free_or_pay
      t.string :name
      t.string :short_name
      t.boolean :black_flag

      t.timestamps null: false
    end
  end
end
