require 'crack/xml'
class Profile < ActiveRecord::Base
  belongs_to :applicant

  validates :born_on,
            presence: true,
            date: { before: Proc.new { 16.years.ago } }

  before_validation { self.ssn && self.ssn.to_s.gsub!('-','') }
  validates :ssn,
            allow_nil: true,
            length: { is: 9 },
            numericality: { only_integer: true }

  validates :phone_number,
            :length   => {
              is: 10,
              allow_nil: true },
            numericality:  {
              :only_integer => true,
              :allow_nil => true }

  validates :was_ever_evicted, inclusion: [true, false]

  validates :is_felon, inclusion: [true, false]

  validates :emergency_contact_phone_number,
            :length   => {
              is: 10 },
            numericality: {
              :only_integer => true }

  validates :current_home_moved_in_on,
             allow_nil: true,
             date: { before: Proc.new { Date.today } }

  validates :previous_home_moved_in_on,
             allow_nil: true,
             date: { before: Proc.new { Date.today } }

  validates :employment_status,
              presence: true,
              inclusion: { in: %w( student employed military retired unemployed ) }

  validates :current_employment_monthly_income,
             allow_nil: true,
             numericality: { minimum: 0 }

  validates :current_employment_employer_phone_number,
            :length   => {
               is: 10,
               allow_nil: true },
            numericality: {
               :only_integer => true,
               :allow_nil => true }

  validates :previous_employment_monthly_income,
             allow_nil: true,
             numericality: { minimum: 0 }

  validates :previous_employment_employer_phone_number,
             :length   => {
               is: 10,
               allow_nil: true },
              numericality: {
               :only_integer => true,
               :allow_nil => true }

  validates :previous_employment_employer_email_address,
              :email_format => {
                :allow_nil  => true,
                :check_mx   => true }

  validates :cosigner_email_address,
              :email_format => {
                :allow_nil  => true,
                :check_mx   => true }

  validates_presence_of :bank_name,
                        :bank_city_and_state,
                        :character_reference_name,
                        :character_reference_contact_info,
                        :emergency_contact_name,
                        :emergency_contact_phone_number,
                        :current_home_street_address,
                        :current_home_moved_in_on,
                        :current_home_owner,
                        :current_home_owner_contact_info,
                        :current_employment_employer_email_address
  before_validation :init

  def init
    self.is_felon  ||= false
    self.was_ever_evicted ||= false
  end
  
end
