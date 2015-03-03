class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.attachment :attachment
      t.references  :property_manager
      t.timestamps
    end
  end
end
