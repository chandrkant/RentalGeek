class AddGeospatialIndex < ActiveRecord::Migration
  def change
    add_index :rental_complexes, [ :latitude, :longitude ]
  end
end
