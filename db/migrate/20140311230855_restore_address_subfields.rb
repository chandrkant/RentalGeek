class RestoreAddressSubfields < ActiveRecord::Migration
  def change
  	add_column :rental_complexes, :street_name			, :string
  	add_column :rental_complexes, :cross_street_name, :string

#    RentalComplex.all.each do |rental_complex|
#      
#      rental_complex.full_address_will_change!
#      rental_complex.save!
#    end

#  	change_column :rental_complexes, :street_name			  , :string, :null => false
#  	change_column :rental_complexes, :cross_street_name , :string, :null => false
  end
end

