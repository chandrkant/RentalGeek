class RentalOffering < ActiveRecord::Base

  strip_attributes
  serialize :scrape_amenities,Array

  belongs_to  :rental_complex
  has_many    :property_photos, dependent: :destroy
  has_many    :starred_properties, dependent: :destroy
  has_one     :property_manager, through: :rental_complex
  scope :applicants, order('applies_count DESC')
  validates :rental_complex, :presence => true

  validates :bedroom_count,
              :presence => true,
              :numericality => {  :greater_than_or_equal_to => 0,
                                  :less_than                => 100,
                                  :only_integer             => true }

  validates :full_bathroom_count,
              :presence => true,
              :numericality => {  :greater_than_or_equal_to => 0,
                                  :less_than                => 100,
                                  :only_integer             => true }

  validates :half_bathroom_count,
              :presence => true,
              :numericality => {  :greater_than_or_equal_to => 0,
                                  :less_than                => 100,
                                  :only_integer             => true }

  validates :monthly_rent_floor,
              :presence => true,
              :numericality => {  :greater_than_or_equal_to => 50,
                                  :less_than                => 15_000,
                                  :only_integer             => true }

  validates :monthly_rent_ceiling,
              :presence => true,
              :numericality => {  :greater_than_or_equal_to => :monthly_rent_floor,
                                  :less_than                => 15_000,
                                  :only_integer             => true }

  validates :square_footage_floor,
              :numericality => {  :greater_than_or_equal_to => 10,
                                  :less_than                => 100_000,
                                  :only_integer             => true,
                                  :allow_nil                => true }

  validates :square_footage_ceiling,
              :numericality => {  :greater_than_or_equal_to => :square_footage_floor,
                                  :less_than                => 100_000,
                                  :only_integer             => true,
                                  :allow_nil                => true }

  validates :rental_offering_type,
              :inclusion => {
                :in         => %w( Apartment Duplex House Townhouse ),
                :allow_nil  => true,
                :allow_blank=> false }

  validates :url, :url => { :allow_nil => true, :allow_blank => false }

  validates :origin_listing_id,
              :uniqueness => {
                allow_nil: true,
                allow_blank: false }

  default_value_for(:earliest_available_on) { Date.today.next_month.beginning_of_month }

  default_value_for(:half_bathroom_count, 0)

  has_many  :applies
  has_many  :applicants, through: :applies, :source => :applicable, :source_type => "Applicant"

  include FlagShihTzu

  has_flags 1 => :buzzer_intercom,
            2 => :central_air,
            3 => :deck_patio,
            4 => :dishwater,
            5 => :doorman,
            6 => :elevator,
            7 => :fireplace,
            8 => :gym,
            9 => :hardwood_floor,
            10 => :new_appliances,
            11 => :parking_garage,
            12 => :parking_outdoor,
            13 => :pool,
            14 => :storage_space,
            15 => :vaulted_ceiling,
            16 => :walkin_closet,
            17 => :washer_dryer,
            18 => :yard_private,
            19 => :yard_shared,
            :column => 'amenities'

  def monthly_rent=(value)
    self.monthly_rent_floor, self.monthly_rent_ceiling = [value, value]
  end

  def square_footage=(value)
    self.square_footage_floor, self.square_footage_ceiling = [value, value]
  end

  def set_fixture_value_for_earliest_available_on!
    self.update_attributes!(
      earliest_available_on: [
        Date.today.last_month.beginning_of_month,
        Date.today.next_month.beginning_of_month
      ].sample)
  end
end

