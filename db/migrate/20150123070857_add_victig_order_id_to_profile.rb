class AddVictigOrderIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :victig_order_id, :string
    add_column :profiles, :victig_url, :string
  end
end
