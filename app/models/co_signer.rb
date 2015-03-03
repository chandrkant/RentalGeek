class CoSigner < ActiveRecord::Base
  belongs_to :applicant
  has_many :co_sign

  accepts_nested_attributes_for :co_sign, :reject_if => :all_blank

  validates_presence_of :first_name,
                        :last_name,
                        :ssn,
                        :dob,
                        :address,
                        :city,
                        :state,
                        :zip_code,
                        :phone,
                        :email,
                        :rent_own,
                        :landlord_phone,
                        :rent_mortage,
                        :employer_name,
                        :emp_position,
                        :m_gross_income,
                        :a_source_income,
                        :marrital_status,
                        :spouse_name,
                        :spouse_ssn,
                        :spouse_dob,
                        :spouse_employer_name,
                        :spouse_position,
                        :spouse_monthly_gross_income,
                        :spouse_additional_source_income,
                        :saving_account_bank_name,
                        :checking_account_bank_name
end
