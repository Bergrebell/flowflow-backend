class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.datetime :datetime
      t.float :value
      t.integer :warn_level, null: true
      t.integer :max_24h
      t.integer :warn_level_24h, null: true
      t.string :type

      t.references :station, index: true

      t.timestamps
    end
  end
end
