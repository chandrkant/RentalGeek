class AddscrapeAmenitiesToRentalOffering < ActiveRecord::Migration
  def change
  	add_column :rental_offerings, :scrape_amenities, :text
  end
end
