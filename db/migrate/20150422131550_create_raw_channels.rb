class CreateRawChannels < ActiveRecord::Migration
  def change
    create_table :raw_channels do |t|
      t.string :channel_name
      t.string :channel_free_or_pay

      t.timestamps null: false
    end
  end
end
