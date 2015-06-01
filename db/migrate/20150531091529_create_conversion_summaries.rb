class CreateConversionSummaries < ActiveRecord::Migration
  def change
    create_table :conversion_summaries do |t|
      t.integer :raw_channel_count
      t.integer :final_raw_channel_count
      t.integer :starting_channel_count
      t.integer :channels_created
      t.integer :channels_skipped
      t.integer :final_channel_count
      t.integer :raw_program_count
      t.integer :final_raw_program_count
      t.integer :starting_program_count
      t.integer :programs_created
      t.integer :programs_skipped
      t.integer :final_program_count
      t.boolean :conversion_completed

      t.timestamps null: false
    end
  end
end
