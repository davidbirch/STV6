class AddHighDefToChannels < ActiveRecord::Migration[5.2]
  def change
    add_column :channels, :four_k_flag, :boolean
  end
end
