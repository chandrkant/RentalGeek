class RemoveEarliestAvailableOnData < ActiveRecord::Migration
  def change
    RentalOffering.update_all earliest_available_on: nil
  end
end

