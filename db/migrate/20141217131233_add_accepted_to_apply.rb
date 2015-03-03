class AddAcceptedToApply < ActiveRecord::Migration
  def change
    add_column :applies, :accepted, :boolean
  end
end
