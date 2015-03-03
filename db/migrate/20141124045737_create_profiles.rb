class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.date   :born_on
      t.string   :ssn
      t.string   :drivers_license_number
      t.string   :drivers_license_state
      t.string   :phone_number
      t.string   :bank_name
      t.string   :bank_city_and_state
      t.text     :pets_description
      t.text     :vehicles_description
      t.boolean  :was_ever_evicted
      t.text     :was_ever_evicted_explanation
      t.boolean  :is_felon
      t.text     :is_felon_explanation
      t.string   :character_reference_name
      t.string   :character_reference_contact_info
      t.string   :emergency_contact_name
      t.string   :emergency_contact_phone_number
      t.string   :current_home_street_address
      t.date     :current_home_moved_in_on
      t.text     :current_home_dissatisfaction_explanation
      t.string   :current_home_owner
      t.string   :current_home_owner_contact_info
      t.string   :previous_home_street_address
      t.date     :previous_home_moved_in_on
      t.date     :previous_home_moved_out
      t.text     :previous_home_dissatisfaction_explanation
      t.string   :previous_home_owner
      t.string   :previous_home_owner_contact_info
      t.string   :employment_status
      t.string   :current_employment_position
      t.integer  :current_employment_monthly_income
      t.string   :current_employment_supervisor
      t.string   :current_employment_employer
      t.string   :current_employment_employer_phone_number
      t.string   :current_employment_employer_email_address
      t.string   :current_employment_started_on
      t.string   :previous_employment_position
      t.integer  :previous_employment_monthly_income
      t.string   :previous_employment_supervisor
      t.string   :previous_employment_employer
      t.string   :previous_employment_employer_phone_number
      t.string   :previous_employment_employer_email_address
      t.string   :previous_employment_started_on
      t.string   :previous_employment_ended_on
      t.integer  :other_income_monthly_amount
      t.string   :other_income_sources
      t.string   :cosigner_name
      t.string   :cosigner_email_address
      t.date     :desires_to_move_in_on
      t.text     :roommates_description
      t.references :applicant
      t.timestamps
    end
  end
end
