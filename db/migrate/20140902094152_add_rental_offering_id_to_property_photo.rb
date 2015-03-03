class AddRentalOfferingIdToPropertyPhoto < ActiveRecord::Migration
  def change
    add_column :property_photos, :rental_offering_id, :integer
  end
end
