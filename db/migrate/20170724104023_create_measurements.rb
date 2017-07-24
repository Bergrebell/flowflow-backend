class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.datetime :datetime
      t.integer :value
      t.integer :max_24h

      t.timestamps
    end
  end
end
