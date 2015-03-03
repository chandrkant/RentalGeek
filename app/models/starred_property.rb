class StarredProperty < ActiveRecord::Base
	belongs_to  :applicant
	belongs_to  :rental_offering
  validates_uniqueness_of :applicant_id, :scope => [:rental_offering_id]

end
