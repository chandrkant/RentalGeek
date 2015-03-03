class AddWebsiteToPropertyManagers < ActiveRecord::Migration
  def change
    add_column :property_managers, :url, :string, :limit => 511, :null => false
  end
end
