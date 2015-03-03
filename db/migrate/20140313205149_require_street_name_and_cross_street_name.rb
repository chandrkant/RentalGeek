class RequireStreetNameAndCrossStreetName < ActiveRecord::Migration
  def change
    	change_column :rental_complexes, :street_name			  , :string, :null => false
    	change_column :rental_complexes, :cross_street_name , :string, :null => false
  end
end

