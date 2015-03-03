class PropertyPhotoSerializer < ActiveModel::Serializer

  attributes  :id,:photo,:thumb

  private

  	def thumb
  		object.photo_thumb_url
  	end
    def photo
      object.photo_full_url
    end
end
