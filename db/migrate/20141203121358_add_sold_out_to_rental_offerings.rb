class AddSoldOutToRentalOfferings < ActiveRecord::Migration
  def change
    add_column :rental_offerings, :sold_out, :boolean, :default => false
  end
end
