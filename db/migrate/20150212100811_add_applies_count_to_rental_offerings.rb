class AddAppliesCountToRentalOfferings < ActiveRecord::Migration
  def self.up
      add_column :rental_offerings, :applies_count, :integer, default: 0
      RentalOffering.reset_column_information
      rental_offerings=RentalOffering.all
      rental_offerings.each do |rental_offering|
        RentalOffering.update_counters rental_offering.id, :applies_count => rental_offering.applies.where(:accepted=>[nil,true]).count
      end
  end

  def self.down
    remove_column :rental_offerings, :applies_count
  end
end




