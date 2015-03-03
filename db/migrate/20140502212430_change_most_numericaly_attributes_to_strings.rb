class ChangeMostNumericalyAttributesToStrings < ActiveRecord::Migration
  def change
    
    change_column :applicants, :ssn                                       , :string
    change_column :applicants, :phone_number                              , :string
    change_column :applicants, :emergency_contact_phone_number            , :string
    change_column :applicants, :current_employment_employer_phone_number  , :string
    change_column :applicants, :previous_employment_employer_phone_number , :string
    change_column :applicants, :born_on                                   , :string, null: false
    change_column :applicants, :current_home_moved_in_on                  , :string
    change_column :applicants, :previous_home_moved_in_on                 , :string
    change_column :applicants, :current_employment_started_on             , :string
    change_column :applicants, :current_home_moved_in_on                  , :string
    change_column :applicants, :current_employment_started_on             , :string
    change_column :applicants, :previous_employment_started_on            , :string
    change_column :applicants, :previous_employment_ended_on              , :string
    
    remove_index  :applicants, name: "index_applicants_on_ssn"
  end
end
