class AddAmenitiesToRentalOffering < ActiveRecord::Migration
  def change
  	add_column :rental_offerings, :amenities, :integer, :null => false, :default => 0
  end
end
