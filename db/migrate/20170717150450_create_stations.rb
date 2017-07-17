class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.integer :station_id
      t.string :name
      t.references :water, index: true

      t.timestamps
    end
  end
end
