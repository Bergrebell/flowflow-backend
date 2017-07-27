class AddMostRecentBooleanToMeasurements < ActiveRecord::Migration[5.0]
  def change
    add_column :measurements, :most_recent, :boolean
  end
end
