class AddSalesyStuffToComplexes < ActiveRecord::Migration
  def change
    add_column :rental_complexes, :salesy_description, :text
  end
end
