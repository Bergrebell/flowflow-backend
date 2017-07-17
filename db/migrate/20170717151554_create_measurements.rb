class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.integer :quantity
      t.integer :maximum_quantity
      t.datetime :reading_time
      t.references :station, index: true

      t.timestamps
    end
  end
end
