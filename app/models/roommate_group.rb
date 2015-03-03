class RoommateGroup < ActiveRecord::Base
	has_and_belongs_to_many :applicants
	has_many :invitations, dependent: :destroy
	belongs_to :owner, class_name: 'Applicant', foreign_key: 'applicant_id'
  has_many :applies, as: :applicable, dependent: :destroy
	validates :name, :presence => true
end
