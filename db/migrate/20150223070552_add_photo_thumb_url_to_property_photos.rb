class AddPhotoThumbUrlToPropertyPhotos < ActiveRecord::Migration
  def change
    add_column :property_photos, :photo_thumb_url, :string
    add_column :property_photos, :photo_full_url, :string
  end
end
