class AddWalkTimeToRentalComplex < ActiveRecord::Migration
  def change
  	add_column :rental_complexes, :walk_time, :string
  end
end
