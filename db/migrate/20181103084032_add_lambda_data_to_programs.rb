class AddLambdaDataToPrograms < ActiveRecord::Migration[5.2]
  def change
    add_column :programs, :sport_prediction, :string
    add_column :programs, :sport_prediction_started_at, :datetime
    add_column :programs, :sport_prediction_completed_at, :datetime
  end
end
