class CreateRentalComplexes < ActiveRecord::Migration
  def change
    create_table :rental_complexes do |t|
      
      t.references  :rentalgeek_property_manager, :null => false
      t.integer     :rentalgeek_id, :null => false
      
      t.string    :street_address, :null => false
      t.string    :city, :null => false
      t.integer   :zip5, :null => false
      
      t.float     :latitude , :null => false
      t.float     :longitude, :null => false
      
      t.boolean   :allows_cats, :default => true
      t.boolean   :allows_dogs, :default => false

      t.string    :name, :null => false
            
      t.timestamps
    end
    
    add_index :rental_complexes, :rentalgeek_id, :unique => true
  end
end
