class RemoveForeignKeyConstraints < ActiveRecord::Migration
  def change
    remove_foreign_key "rental_complexes", name: "rental_complexes_rentalgeek_property_manager_id_fk"
    remove_foreign_key "rental_offerings", name: "rental_offerings_rentalgeek_rental_complex_id_fk"
  end
end
