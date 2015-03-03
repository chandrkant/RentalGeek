class AddFacebookImageToApplicants < ActiveRecord::Migration
  def change
  	add_column :applicants, :facebook_image, :string
  	add_column :applicants, :google_image, :string
  end
end
