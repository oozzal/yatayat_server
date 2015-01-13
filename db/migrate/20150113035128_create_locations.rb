class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal  :latitude, precision: 10, scale: 6
      t.decimal  :longitude, precision: 10, scale: 6
      t.string   :city
      t.string   :address
      t.string   :name, index: true

      t.timestamps
    end
  end
end

