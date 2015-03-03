class Attachment < ActiveRecord::Base
  belongs_to :property_manager
  has_attached_file :attachment,
  :storage => :fog,
  :fog_credentials => "#{Rails.root}/config/gce.yml",
  :fog_directory=>"rentalgeek",
  :path => Rails.env.production? ? "attachments/:id_:basename.:extension" : "attachments_staging/:id_:basename.:extension",
  :url => Rails.env.production? ? "attachments/:id_:basename.:extension" : "attachments_staging/:id_:basename.:extension"
  validates_attachment_content_type :attachment, :content_type => "application/pdf"
end
