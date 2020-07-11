class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.float :price
      t.string :model
      t.integer :year
      t.string :address
      t.string :engine_type
      t.string :transmission
      t.integer :kilometers
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
