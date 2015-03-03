class AddAttachmentPhotoToPropertyPhotos < ActiveRecord::Migration
  def self.up
    change_table :property_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :property_photos, :photo
  end
end
