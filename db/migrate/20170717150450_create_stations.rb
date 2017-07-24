class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.string :number
      t.string :name
      t.string :water_body_name
      t.string :water_body_type
      t.integer :easting
      t.integer :northing

      t.timestamps
    end
  end
end
