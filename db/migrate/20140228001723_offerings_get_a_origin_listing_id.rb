class OfferingsGetAOriginListingId < ActiveRecord::Migration
  def change
    add_column :rental_offerings, :origin_listing_id, :string
    
    # so, we can't easily scope uniqueness of origin listin ID to Property Managers, but this is the next best thing.
    add_index :rental_offerings, [:rentalgeek_rental_complex_id, :origin_listing_id], 
      :unique => true,
      :name   => :index_offerings_on_complex_id_and_origin_listing_id
  end
end

