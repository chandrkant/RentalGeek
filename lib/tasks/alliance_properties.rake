desc "Scrape properties list from https://alliancepropertymgmt.appfolio.com/listings/?1408451092069"
task 'alliance_properties' => :environment do
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'mechanize'
    require 'geokit'
    require 'similar_text'
    begin
        all_url = RentalOffering.all.map(&:url)
        applicant = Applicant.find_by_email("alliance@alliancemhk.com")
        if applicant.nil?
          password = SecureRandom.hex(4)
          applicant = Applicant.create(email: "alliance@alliancemhk.com", password: password, password_confirmation: password)
          ApplicantMailer.delay.landlord_signin("alliance@alliancemhk.com", password)
        end
        if applicant.property_manager.nil?
            property_manager = PropertyManager.create(name: "Alliance Property Management", customer_contact_email_address: "alliance@alliancemhk.com", customer_contact_phone_number: 7855392300,url: 'http://www.alliancemhk.com/', applicant_id: applicant.id)
        end
        property_manager = applicant.property_manager
        defined_amenities = ["buzzer_intercom","central_air","deck_patio","dishwater","doorman","elevator","fireplace","gym",
                                "hardwood_floor","new_appliances","parking_garage","parking_outdoor","pool","storage_space",
                                "vaulted_ceiling","walkin_closet","washer_dryer","yard_private","yard_shared"]
        url = "https://alliancepropertymgmt.appfolio.com/listings/?1408451092069"
        mechanize = Mechanize.new
        page = mechanize.get(url)
        page.search('.listing-item').each do |property|
            begin
                details_url = "https://alliancepropertymgmt.appfolio.com"+property.search(".js-link-to-detail").attr("href").value
                unless all_url.include?(details_url)
                    mechanize = Mechanize.new
                    details_page = mechanize.get(details_url)
                    image =  property.search(".listing-item__figure-container a img").attr('data-original').value
                    monthely_rent =  property.search("dd.detail-box__value").first.text.gsub(",","").gsub("$","")
                    bed = property.search("dd.detail-box__value").last.text.split("/").first.scan(/\d+/).first
                    bath = property.search("dd.detail-box__value").last.text.split("/").last.scan(/\d+/).first
                    address = property.search("span.js-listing-address").text
                    space = property.search("span.u-space-rm").text.gsub(",","").scan(/\d+/).first

                    earliest_available =  property.search("span.js-listing-available").text == "Available Now" ? Time.now : property.search("span.js-listing-available").text.split(" ").last

                    property_manager_name = "Alliance Property Management, Inc."
                    phone = "7855392300"
                    latlang =Geokit::Geocoders::GoogleGeocoder.geocode address
                    lat_lang = latlang.ll
                    rental_complex = RentalComplex.create!(property_manager_id: property_manager.id, latitude: lat_lang.split(",").first, longitude: lat_lang.split(",").last, name: property_manager_name, url: details_url, full_address: address, customer_contact_email_address: "alliance@alliancemhk.com", customer_contact_phone_number: phone)
                    puts '************* RentalComplex Created ***************'
                    rental_offering = RentalOffering.create!(rental_complex_id: rental_complex.id, earliest_available_on: earliest_available, bedroom_count: bed, full_bathroom_count: bath, headline: address, url: details_url, monthly_rent_floor: monthely_rent, monthly_rent_ceiling: monthely_rent, square_footage_floor: space, square_footage_ceiling: space)
                    puts '************* RentalOffering Created ***************'
                    details_page.search("img").each_with_index do |img, index|
                        begin
                            if img.attr("alt")=="" || img.attr("height")=="" || img.attr("width")==""
                                property_photo=rental_offering.property_photos.create(:photo => img.attr("src").gsub("small","medium"))
                                 property_photo.update(photo_thumb_url:property_photo.photo.url(:thumb))
                                 property_photo.update(photo_full_url: property_photo.photo.url(:full))
                                puts '*********** property_photos created ***********'
                            end
                        rescue
                            next
                        end
                    end
                    details_page.search("div.dark_grey li").each do |amenity|
                        begin
                            rental_offering.scrape_amenities << amenity.text
                            rental_offering.save
                        rescue
                            puts "something went wrong to pull amenities"
                            next
                        end

                    end
                end
            rescue
                puts "something went wrong when pulling information"
                next
            end
        end
    rescue
        puts "Something went wrong"
    end

end
