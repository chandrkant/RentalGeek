class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      
      t.references :rentalgeek_applicant      , null: false
      t.references :rentalgeek_rental_offering, null: false
      
      t.integer   :rentalgeek_id, null: false
      
      t.timestamps
    end
    
    add_index :applies, [:rentalgeek_rental_offering_id, :rentalgeek_applicant_id], unique: true, name: 'index_applies_on_rental_offerings_and_applicants'
    add_index :applies, :rentalgeek_id, unique: true
  end
end

