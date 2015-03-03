desc "Scrape properties list from http://www2.mkpropertymgt.com"
task 'mk_properties' => :environment do
	require 'rubygems'
	require 'nokogiri'
	require 'open-uri'
	require 'mechanize'
	require 'geokit'
	begin
    applicant = Applicant.find_by_email("management@mkpropertymgt.com")
    if applicant.nil?
        password = SecureRandom.hex(4)
        applicant = Applicant.create(email: "management@mkpropertymgt.com", password: password, password_confirmation: password)
        ApplicantMailer.delay.landlord_signin("management@mkpropertymgt.com", password)
    end
    if applicant.property_manager.nil?
        property_manager = PropertyManager.create(name: "MK Property Management", customer_contact_email_address: "management@mkpropertymgt.com", customer_contact_phone_number: 7857761936,url: 'http://www2.mkpropertymgt.com', applicant_id: applicant.id)
    end
    property_manager = applicant.property_manager

    defined_amenities = ["buzzer_intercom","central_air","deck_patio","dishwater","doorman","elevator","fireplace","gym",
                            "hardwood_floor","new_appliances","parking_garage","parking_outdoor","pool","storage_space",
                            "vaulted_ceiling","walkin_closet","washer_dryer","yard_private","yard_shared"]
		url = "http://www2.mkpropertymgt.com/index.php?cur_page=0&status=Available&action=searchresults&pclass[]=&sortby=listingsdb_id&sorttype=ASC"
		mechanize = Mechanize.new
		#doc = Nokogiri::HTML(open(url))
		doc = mechanize.get(url)
		loop_count = doc.search(".browse_tool_table table:first td.bt_pages").count.to_i
		loop_count.times do |counter|
			begin
				url = "http://www2.mkpropertymgt.com/index.php?cur_page="+counter.to_s+"&status=Available&action=searchresults&pclass[]=&sortby=listingsdb_id&sorttype=ASC"
				mechanize = Mechanize.new
				page = mechanize.get(url)
				page.search("#unit1").each do |property|

					bed = property.search('.unit-details p:eq(2) b:first').text.split("/").first.scan(/\d+/).first
					bath = property.search('.unit-details p:eq(2) b:first').text.split("/").last.scan(/\d+/).first
					monthely_rent =  property.search('td:last .price').text.scan(/\d+/).first
					address = property.search('td.unit-details p:first').text.gsub("\n","").gsub("Address:","").split.join(" ")
					space = ""
					earliest_available = property.search("div.orange").text.blank? ? Time.now : (property.search("div.orange").text == "Available Date Now" ? Time.now : DateTime.parse(property.search("div.orange").text.gsub("Available Date ","")))
					property_manager_name = "MK Property Management"
					phone = 7857761936
					latlang =Geokit::Geocoders::GoogleGeocoder.geocode address
		            lat_lang = latlang.ll

		            rental_complex = RentalComplex.create!(property_manager_id: property_manager.id, latitude: lat_lang.split(",").first, longitude: lat_lang.split(",").last, name: property_manager_name, url: url, full_address: address, customer_contact_email_address: "management@mkpropertymgt.com", customer_contact_phone_number: phone)
		            puts rental_complex.id
		            rental_offering = RentalOffering.create!(rental_complex_id: rental_complex.id, earliest_available_on: earliest_available, bedroom_count: bed, full_bathroom_count: bath, headline: address, url: url, monthly_rent_floor: monthely_rent, monthly_rent_ceiling: monthely_rent, square_footage_floor: space, square_footage_ceiling: space)
					puts rental_offering.id
					property.search(".gallery10 a").each do |img|
						begin
							rental_offering.property_photos.create(:photo => img.attr('href'))
						rescue
							puts "something went wrong when pulling image"
							next
						end
					end
				end
			rescue
				puts "something went wrong when pulling property information"
				next
			end
		end
	rescue
        puts "Something went wrong"
    end
end
