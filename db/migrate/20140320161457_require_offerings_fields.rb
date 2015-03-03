class RequireOfferingsFields < ActiveRecord::Migration
  def change
    change_column :rental_offerings, :bedroom_count, :integer, :null => false
    change_column :rental_offerings, :full_bathroom_count, :integer, :null => false
    change_column :rental_offerings, :half_bathroom_count, :integer, :null => false, :default => 0
    
  end
end
