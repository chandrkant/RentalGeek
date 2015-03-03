  desc "remove duplicates properties photos"
  task 'remove_duplicates' => :environment do
   require 'rubygems'
   grouped=PropertyPhoto.all.group_by{|property_photo| [property_photo.rental_offering_id,property_photo.photo_file_size] }
      begin
        grouped.values.each do |duplicates|
          # the first one we want to keep right?
          first_one = duplicates.shift # or pop for last one
          # if there are any more left, they are duplicates
          # so delete all of them
          duplicates.each{|double| double.destroy} # duplicates can now be destroyed
        end
         puts "************************************"
         puts "Duplicates properties photos removed!"
         puts "************************************"
      rescue => e
        puts "Something went wrong #{e.message}"
      end
  end
