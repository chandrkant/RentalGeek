class AlliancePropertyManagementRental

  def full_address
    @hash[:address]  
  end
  
  def latitude
    @hash[:latitude]
  end
  
  def longitude
    @hash[:longitude]
  end
  
  def default_photo_url
    @hash[:default_photo_url]
  end
  
  def detail_page_url
    URI.join('https://alliancepropertymgmt.appfolio.com',@hash[:detail_page_url]).to_s
  end
  
  def monthly_rent
    @hash[:market_rent].sub(/\A\$/,'').sub(',','').to_i
  end
  
  def bedroom_count
    @hash[:unit_specs].match(/(\d+) bd/).captures.first.to_i
  end
  
  def full_bathroom_count
    @hash[:unit_specs].match(/(\d+)((\.0)|(\.5))? ba/).captures.first.to_i
  end
  
  def half_bathroom_count
    @hash[:unit_specs].match(/\d+(.5)? ba/).captures.first.to_f == 0.5 ? 1 : 0
  end
  
  def square_footage
    if @hash[:unit_specs].match(/sq ft/)
      @hash[:unit_specs].match(/((\d+\,\d+)|\d+{3}) sq ft/).captures.first.sub(',','').to_i
    end
  end
  
  def origin_listing_id
    @hash[:listing_id].to_i
  end
  
  def to_rental_offering_with_rental_complex
    _rental_offering = rental_offering
    _rental_offering.rental_complex = rental_complex
    _rental_offering
  end
  
  def initialize(hash)
    @hash = hash.with_indifferent_access
  end

private

  def rental_offering
    RentalOffering.new(
      :bedroom_count => bedroom_count,
      :full_bathroom_count => full_bathroom_count,
      :half_bathroom_count => half_bathroom_count,
      :url => detail_page_url,
      :monthly_rent => monthly_rent,
      :square_footage => square_footage,
      :origin_listing_id => origin_listing_id)
  end
  
  def rental_complex
    RentalComplex.new(
      :property_manager => PropertyManager.where(name: "Alliance Property Management").first!,
      :latitude => latitude,
      :longitude => longitude,
      :full_address => full_address)
  end
end

