class MakeFullBathrooms < ActiveRecord::Migration
  def change
    rename_column :rental_offerings, :bathroom_count, :full_bathroom_count
  end
end

