class AddUrlToComplexesAndOfferings < ActiveRecord::Migration
  def change
    add_column :rental_complexes, :url, :string, :limit => 511
    add_column :rental_offerings, :url, :string, :limit => 511
  end
end

