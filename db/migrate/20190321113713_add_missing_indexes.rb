class AddMissingIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :channels, :provider_id
    add_index :jobs, [:detail_id, :detail_type]
    add_index :keywords, :sport_id
    add_index :programs, :keyword_id
  end
end
