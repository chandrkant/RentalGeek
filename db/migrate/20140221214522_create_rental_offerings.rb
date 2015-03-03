class CreateRentalOfferings < ActiveRecord::Migration
  def change
    create_table :rental_offerings do |t|

      t.integer     :rentalgeek_id, :null => false
      t.references  :rentalgeek_rental_complex, :null => false
      
      t.date      :earliest_available_on
      
      t.integer   :bedroom_count
      t.integer   :bathroom_count
      t.integer   :half_bathroom_count
      
      t.integer   :monthly_rent, :null => false
      
      t.integer   :square_footage
      
      t.text      :salesy_description
      
      t.string    :rental_offering_type
      
      t.string    :headline, :null => false

      t.timestamps
    end

    add_index :rental_offerings, :rentalgeek_id, :unique => true
  end
end
