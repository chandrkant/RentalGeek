class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "rental_complexes", "property_managers", name: "rental_complexes_rentalgeek_property_manager_id_fk", column: "rentalgeek_property_manager_id", primary_key: "rentalgeek_id"
    add_foreign_key "rental_offerings", "rental_complexes", name: "rental_offerings_rentalgeek_rental_complex_id_fk", column: "rentalgeek_rental_complex_id", primary_key: "rentalgeek_id"
  end
end
