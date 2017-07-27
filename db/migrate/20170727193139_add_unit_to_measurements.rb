class AddUnitToMeasurements < ActiveRecord::Migration[5.0]
  def change
    add_column :measurements, :unit, :string
  end
end
