class AcceptMoneyOrders < ActiveRecord::Migration
  def change
    add_column :property_managers, :accepts_money_orders, :boolean, :null => false, :default => false
  end
end
