class RentalComplex < ActiveRecord::Base

  strip_attributes
  serialize :nearby_places,Array

  has_many  :rental_offerings, dependent: :destroy
  has_many  :property_photos, through: :rental_offerings
  has_many  :applies, through: :rental_offerings

  belongs_to  :property_manager

  validates :property_manager, :presence => true

  validates :latitude, :presence => true
  validates :longitude, :presence => true

  validates :url, :url => { :allow_nil => true }

  validates :full_address, :presence => true

  validates :customer_contact_email_address, :email_format => { :allow_nil  => true }

  validates :customer_contact_phone_number,
              :length   => {
                is: 10,
                allow_nil: true },
              :numericality => {
                :only_integer => true,
                :allow_nil => true }

  validates :street_name, presence: true

  validates :cross_street_name, presence: true
  accepts_nested_attributes_for :rental_offerings

#  validates :zip5,
#              :presence => true,
#              :numericality => {  :greater_than_or_equal_to => 00501,    # https://en.wikipedia.org/wiki/ZIP_code#Primary_State_Prefixes
#                                  :less_than_or_equal_to    => 99950 }

  geocoded_by :full_address

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geodata = results.first
      # [:address, :address_components, :address_components_of_type, :cache_hit, :cache_hit=, :city,
      # :coordinates, :country, :country_code, :data, :data=, :formatted_address, :geometry, :latitude,
      # :longitude, :neighborhood, :postal_code, :precision, :province, :province_code, :route, :state,
      # :state_code, :street_address, :street_number, :sub_state, :sub_state_code, :types]

      obj.street_name = geodata.route
    end
  end

  before_validation :geocode,
                    :reverse_geocode,
                    :set_cross_street_name, if: -> (obj) {

    obj.full_address.present? &&
    obj.full_address_changed? }

  before_create :walk_time_duration, :nearby_place

#  def street_address_with_city
#    self.full_address.sub(/(,| ){1,3}[A-Z]{2},?\s+\d{4,5}\z/,'')
#  end

private

  def set_cross_street_name
    geonames_result = GeoNamesAPI::NearestIntersection.find(self.latitude, self.longitude)
    self.cross_street_name = geonames_result.intersection['street2'] if geonames_result.intersection.present?
  end

  def walk_time_duration
    destination = self.full_address.gsub(" ","+")
    url = "http://maps.googleapis.com/maps/api/directions/json?origin=kansas+state+university&destination="+destination+"&sensor=false"
    response = RestClient.get(url)
    json_res = JSON.parse response
    time = json_res["routes"][0]["legs"][0]["duration"]["text"]
    self.walk_time = time
  end

  def nearby_place
    @client = GooglePlaces::Client.new("AIzaSyB2cpHw3BFwZoUnchVGuRIS7kMfu9VOwkU")
    response = @client.spots(self.latitude, self.longitude, :types => ['cafe', 'laundry', 'shopping_mall', 'restaurant', 'food'])
    response.each do |place|
      self.nearby_places << place.name
    end
  end
end

