class AddRangesRentalsData < ActiveRecord::Migration
  def change
    remove_column :rental_offerings, :monthly_rent,  :integer
    remove_column :rental_offerings, :square_footage,:integer

    add_column :rental_offerings, :monthly_rent_floor,    :integer, :null => false
    add_column :rental_offerings, :monthly_rent_ceiling,  :integer, :null => false

    add_column :rental_offerings, :square_footage_floor,  :integer
    add_column :rental_offerings, :square_footage_ceiling,:integer
  end
end

