class AddBlackFlagToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :black_flag, :boolean
  end
end
