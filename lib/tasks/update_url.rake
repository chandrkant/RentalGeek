desc "Scrape properties list from https://alliancepropertymgmt.appfolio.com/listings/?1408451092069"
task 'update_url' => :environment do
    require 'rubygems'
       count=0
       PropertyPhoto.all.each do |property_photo|
        begin
          puts "****************Update Property photos ********************"
          property_photo.update(photo_thumb_url:property_photo.photo.url(:thumb))
          property_photo.update(photo_full_url: property_photo.photo.url(:full))
          count=count+1
        rescue => e
          puts "Something went wrong #{e.message}"
        end
        puts "***********************************************************"
       end
       puts "Total update #{count}"


end
