class RemovePetStuff < ActiveRecord::Migration
  def change
    remove_column :rental_complexes, :allows_cats
    remove_column :rental_complexes, :allows_dogs
  end
end
