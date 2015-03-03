class RenameApplicantTransactionsTableToTransactions < ActiveRecord::Migration
  def change
  	rename_table :applicant_transactions, :transactions
  end
end
