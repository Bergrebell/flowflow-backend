class CreateWaters < ActiveRecord::Migration[5.0]
  def change
    create_table :waters do |t|
      t.string :name

      t.timestamps
    end
  end
end
