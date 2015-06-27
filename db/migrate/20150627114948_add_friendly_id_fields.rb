class AddFriendlyIdFields < ActiveRecord::Migration
  def change
    add_column :regions, :url_friendly_name, :string
  end
end
