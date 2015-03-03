class RemoveFieldFromApplicant < ActiveRecord::Migration
  def change
    change_table :applicants do |t|
      t.remove   :born_on
      t.remove   :ssn
      t.remove   :drivers_license_number
      t.remove   :drivers_license_state
      t.remove   :phone_number
      t.remove   :bank_name
      t.remove   :bank_city_and_state
      t.remove   :pets_description
      t.remove   :vehicles_description
      t.remove   :was_ever_evicted
      t.remove   :was_ever_evicted_explanation
      t.remove   :is_felon
      t.remove   :is_felon_explanation
      t.remove   :character_reference_name
      t.remove   :character_reference_contact_info
      t.remove   :emergency_contact_name
      t.remove   :emergency_contact_phone_number
      t.remove   :current_home_street_address
      t.remove   :current_home_moved_in_on
      t.remove   :current_home_dissatisfaction_explanation
      t.remove   :current_home_owner
      t.remove   :current_home_owner_contact_info
      t.remove   :previous_home_street_address
      t.remove   :previous_home_moved_in_on
      t.remove   :previous_home_dissatisfaction_explanation
      t.remove   :previous_home_owner
      t.remove   :previous_home_owner_contact_info
      t.remove   :employment_status
      t.remove   :current_employment_position
      t.remove   :current_employment_monthly_income
      t.remove   :current_employment_supervisor
      t.remove   :current_employment_employer
      t.remove   :current_employment_employer_phone_number
      t.remove   :current_employment_employer_email_address
      t.remove   :current_employment_started_on
      t.remove   :previous_employment_position
      t.remove   :previous_employment_monthly_income
      t.remove   :previous_employment_supervisor
      t.remove   :previous_employment_employer
      t.remove   :previous_employment_employer_phone_number
      t.remove   :previous_employment_employer_email_address
      t.remove   :previous_employment_started_on
      t.remove   :previous_employment_ended_on
      t.remove   :other_income_monthly_amount
      t.remove   :other_income_sources
      t.remove   :cosigner_name
      t.remove   :cosigner_email_address
      t.remove   :desires_to_move_in_on
      t.remove   :roommates_description
    end
  end
end
