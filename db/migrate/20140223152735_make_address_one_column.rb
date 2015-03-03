class MakeAddressOneColumn < ActiveRecord::Migration
  def change
    remove_column :rental_complexes,  :street_address, :string
    remove_column :rental_complexes,  :city, :string
    remove_column :rental_complexes,  :zip5, :string
    
    add_column    :rental_complexes,  :full_address, :string, :null => false, :limit => 511
  end
end

