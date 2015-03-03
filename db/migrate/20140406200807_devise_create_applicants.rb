class DeviseCreateApplicants < ActiveRecord::Migration
  def change
    create_table(:applicants) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps
      
      ### END DEVISE
      
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_initial, limit: 3
      
      t.date :born_on, null: false

      t.integer :ssn
            
      t.string :drivers_license_number
      t.string :drivers_license_state
      
      t.integer :phone_number, limit: 8
      
      t.string :bank_name
      t.string :bank_city_and_state
      
      t.text :pets_description
      
      t.text :vehicles_description
      
      t.boolean :was_ever_evicted, null: false
      t.text    :was_ever_evicted_explanation
      
      t.boolean :is_felon, null: false
      t.text    :is_felon_explanation
      
      t.string :character_reference_name
      t.string :character_reference_contact_info
      
      t.string  :emergency_contact_name
      t.integer :emergency_contact_phone_number, limit: 8
      
      t.string  :current_home_street_address
      t.date    :current_home_moved_in_on
      t.text    :current_home_dissatisfaction_explanation
      t.string  :current_home_owner
      t.string  :current_home_owner_contact_info

      t.string  :previous_home_street_address
      t.date    :previous_home_moved_in_on
      t.text    :previous_home_dissatisfaction_explanation
      t.string  :previous_home_owner
      t.string  :previous_home_owner_contact_info
      

      # is not "current_employment_*" because employment status may not be "hired" -JC
      t.string  :employment_status

      t.string  :current_employment_position
      t.integer :current_employment_monthly_income
      t.string  :current_employment_supervisor
      t.string  :current_employment_employer
      t.integer :current_employment_employer_phone_number, limit: 8
      t.string  :current_employment_employer_email_address
      t.date    :current_employment_started_on

      t.string  :previous_employment_position
      t.integer :previous_employment_monthly_income
      t.string  :previous_employment_supervisor
      t.string  :previous_employment_employer
      t.integer :previous_employment_employer_phone_number, limit: 8
      t.string  :previous_employment_employer_email_address
      t.date    :previous_employment_started_on
      t.date    :previous_employment_ended_on

      t.integer :other_income_monthly_amount
      t.string  :other_income_sources
      
      t.string  :cosigner_name
      t.string  :cosigner_email_address
      
      t.integer :rentalgeek_id, null: false
    end

    add_index :applicants, :email,                unique: true
    add_index :applicants, :reset_password_token, unique: true
    # add_index :applicants, :confirmation_token,   unique: true
    # add_index :applicants, :unlock_token,         unique: true
    
    add_index :applicants, :rentalgeek_id, unique: true
    add_index :applicants, :ssn          , unique: true
  end
end

