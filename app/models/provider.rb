class Provider < ActiveRecord::Base
  belongs_to :applicant
  validates_uniqueness_of :uid, :scope => [:applicant_id, :provider]
end
