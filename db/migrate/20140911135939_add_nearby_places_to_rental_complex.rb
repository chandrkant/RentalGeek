class AddNearbyPlacesToRentalComplex < ActiveRecord::Migration
  def change
  	add_column :rental_complexes, :nearby_places, :text
  end
end
