class RemoveRentalgeekId < ActiveRecord::Migration
  def change
    remove_column :applicants, :rentalgeek_id
    remove_column :applies, :rentalgeek_id
    remove_column :rental_complexes, :rentalgeek_id
    remove_column :rental_offerings, :rentalgeek_id
    rename_column :applies, :rentalgeek_applicant_id, :applicant_id
    rename_column :applies, :rentalgeek_rental_offering_id, :rental_offering_id
    rename_column :rental_complexes, :rentalgeek_property_manager_id, :property_manager_id
    rename_column :rental_offerings, :rentalgeek_rental_complex_id, :rental_complex_id
  end
end
