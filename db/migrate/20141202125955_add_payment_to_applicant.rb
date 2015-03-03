class AddPaymentToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :payment, :boolean, :default => false
  end
end
