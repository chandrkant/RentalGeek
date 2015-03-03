class AddCardDetailsToApplicantTransactions < ActiveRecord::Migration
  def change
    add_column :applicant_transactions, :card_type, :string
    add_column :applicant_transactions, :cardholder_name, :string
    add_column :applicant_transactions, :purchased_type, :string
  end
end
