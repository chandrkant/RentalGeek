class CreatePropertyPhotos < ActiveRecord::Migration
  def change
    create_table :property_photos do |t|

      t.timestamps
    end
  end
end
