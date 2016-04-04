class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.string :url_friendly_name
      t.string :short_name
      t.string :url_friendly_short_name
      t.boolean :black_flag
    end
  end
end
