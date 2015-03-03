class AddContactFieldsToRentals < ActiveRecord::Migration
  def change
    add_column :rental_complexes, :customer_contact_email_address , :string
    add_column :rental_complexes, :customer_contact_phone_number  , :integer, :limit => 8
  end
end

