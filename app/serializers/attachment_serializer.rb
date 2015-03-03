class AttachmentSerializer < ActiveModel::Serializer
  attributes  :id, :attachment, :name

  private

    def attachment
      object.attachment.url
    end

    def name
      object.attachment_file_name
    end
end
