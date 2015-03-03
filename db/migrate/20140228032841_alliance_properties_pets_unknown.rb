class AlliancePropertiesPetsUnknown < ActiveRecord::Migration
  def change
#     alliance = PropertyManager.where(:name => 'Alliance Property Management').first!
# #    raise if Rails.env.test? == false && alliance.nil?
#     raise if Rails.env.test? == false && (alliance.rental_complexes.empty? || alliance.rental_complexes.collect(&:rental_offerings).flatten.empty?)
    
    change_column :rental_complexes, :allows_cats, :boolean, :null => true
    change_column :rental_complexes, :allows_dogs, :boolean, :null => true
    
    # alliance.rental_complexes.each do |rental_complex|
    #   rental_complex.allows_cats = nil
    #   rental_complex.allows_dogs = nil
    #   rental_complex.save!
    #   p "r c ##{rental_complex.id} updated (#{rental_complex.allows_dogs} / #{rental_complex.allows_cats})"
    # end
  end
end
