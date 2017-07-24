class CreateParameters < ActiveRecord::Migration[5.0]
  def change
    create_table :parameters do |t|
      t.string :type
      t.integer :variant
      t.string :name
      t.string :unit

      t.timestamps
    end
  end
end
