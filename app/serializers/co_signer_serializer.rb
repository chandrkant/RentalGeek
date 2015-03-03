class CoSignerSerializer < ActiveModel::Serializer
  attributes  :id, :first_name, :last_name, :ssn, :dob, :address,
              :city, :state, :zip_code, :phone, :email, :rent_own,
              :landlord_phone, :rent_mortage,:spouse_employer_name,
              :employer_name, :emp_position, :m_gross_income, :a_source_income,
              :marrital_status, :spouse_name, :spouse_ssn, :spouse_dob,
              :spouse_position, :spouse_monthly_gross_income, :checking_account_bank_name,
              :spouse_additional_source_income, :saving_account_bank_name,
              :lenders_name, :loan_type, :o_court_judgement, :party_lawsuit,
              :property_foreclosed, :declared_bankruptcy, :is_felony

end
