class CreateStarredProperties < ActiveRecord::Migration
  def change
    create_table :starred_properties do |t|
      t.integer :applicant_id
      t.integer :rental_offering_id

      t.timestamps
    end
  end
end
