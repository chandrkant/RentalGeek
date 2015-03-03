class CreateCoSigners < ActiveRecord::Migration
  def change
    create_table :co_signers do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :ssn
      t.date    :dob
      t.string  :address
      t.string  :city
      t.string  :state
      t.integer :zip_code
      t.integer :phone
      t.string  :email
    	t.string	:rent_own
    	t.string	:landlord_phone
    	t.string	:rent_mortage
      t.string  :employer_name
      t.string  :emp_position
      t.integer :m_gross_income
      t.integer :a_source_income
    	t.string	:marrital_status
    	t.string	:spouse_name
    	t.string	:spouse_ssn
    	t.date		:spouse_dob
    	t.string	:spouse_employer_name
    	t.string	:spouse_position
    	t.integer	:spouse_monthly_gross_income
    	t.integer	:spouse_additional_source_income
      t.string  :saving_account_bank_name
      t.string  :checking_account_bank_name
    	t.string  :lenders_name
      t.string  :loan_type
      t.boolean :o_court_judgement
      t.boolean :party_lawsuit
      t.boolean :property_foreclosed
    	t.boolean	:declared_bankruptcy
    	t.boolean	:is_felony
      t.integer :applicant_id
    	t.timestamps
    end
  end
end
