class MakeHeadlineOptional < ActiveRecord::Migration
  def change
    change_column :rental_offerings, :headline, :string, :null => true
  end
end
