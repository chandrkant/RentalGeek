class CreateApplicantTransactions < ActiveRecord::Migration
  def change
    create_table :applicant_transactions do |t|
      t.string :transaction_id
      t.string :status
      t.decimal :amount
      t.integer :applicant_id

      t.timestamps
    end
  end
end
