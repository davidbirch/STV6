class AddFriendlyIdFields < ActiveRecord::Migration
  def change
    add_column :regions, :url_friendly_name, :string
    add_column :sports, :url_friendly_name, :string
    add_column :keywords, :url_friendly_value, :string
    add_column :categories, :url_friendly_name, :string
    add_column :channels, :url_friendly_name, :string
    add_column :channels, :url_friendly_short_name, :string
  end
end
