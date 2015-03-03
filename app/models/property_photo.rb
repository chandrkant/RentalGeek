class PropertyPhoto < ActiveRecord::Base
  belongs_to :rental_offering

	has_attached_file :photo,
	:styles => {
    :thumb => ["130x100", :jpg],
    :full => ["500x500", :jpg]
  },
  :default_style => :full,
	:storage => :fog,
	:storage => :fog,
  :fog_credentials => "#{Rails.root}/config/gce.yml",
  :fog_directory =>"rentalgeek",
  :path => Rails.env.production? ? "photos/:id_:style_:basename.:extension" : "photos_staging/:id_:style_:basename.:extension",
  :url => Rails.env.production? ? "photos/:id_:style_:basename.:extension" : "photos/:id_:style_:basename.:extension"

	validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
