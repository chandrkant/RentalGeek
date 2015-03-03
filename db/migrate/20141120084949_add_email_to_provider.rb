class AddEmailToProvider < ActiveRecord::Migration
  def change
  	add_column :providers, :email,     :string
  	add_column :providers, :name,      :string
  	add_column :providers, :connected, :boolean, :default => true
  	rename_column :providers, :providers, :provider
  end
end
