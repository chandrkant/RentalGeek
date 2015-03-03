class ComplexNamesAreOptional < ActiveRecord::Migration
  def change
    change_column :rental_complexes, :name, :string, :null => true
  end
end
