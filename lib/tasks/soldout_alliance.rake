desc "Scrape properties list from https://alliancepropertymgmt.appfolio.com/listings/?1408451092069"
task 'soldout_alliance' => :environment do
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'mechanize'
    begin
        applicant = Applicant.find_by_email("alliance@alliancemhk.com")
        property_manager = applicant.property_manager
        rental_offerings = property_manager.rental_offerings.where(sold_out: false)
        rental_offerings.each do |offering|
          if offering.url
            url = offering.url
            mechanize = Mechanize.new
            page = mechanize.get(url)
            val = page.search('.error').text.include?('This listing is no longer available')
            if(val)
                offering.update(sold_out: 'true')
                property_applies = offering.applies
                property_applies.each do |apply|
                    email = apply.applicant.email
                    ApplicantMailer.delay.soldout_email(offering.headline,email)
                end
            end
          end
        end
    rescue
        puts "Something went wrong"
    end

end
