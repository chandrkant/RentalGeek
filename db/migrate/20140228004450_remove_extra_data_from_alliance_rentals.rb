class RemoveExtraDataFromAllianceRentals < ActiveRecord::Migration
#   def change
#     alliance = PropertyManager.where(:name => 'Alliance Property Management').first!
# #    raise if Rails.env.test? == false && alliance.nil?
#     raise if Rails.env.test? == false && (alliance.rental_complexes.empty? || alliance.rental_complexes.collect(&:rental_offerings).flatten.empty?)
    
#     alliance.rental_complexes.each do |rental_complex|
#       rental_complex.name = nil
#       rental_complex.save!
#       p "r c ##{rental_complex.id} updated"
      
#       rental_complex.rental_offerings.each do |rental_offering|
#         rental_offering.headline = nil
#         rental_offering.save!
#         p "r o ##{rental_offering.id} updated"
#       end
#     end
#   end
end
