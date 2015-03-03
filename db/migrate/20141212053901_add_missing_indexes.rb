class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :providers, :applicant_id
    add_index :applicants_roommate_groups, [:applicant_id, :roommate_group_id], name: "index_on_applicant_id_and_roommate_group_id"
    add_index :applicants_roommate_groups, :applicant_id
    add_index :applicants_roommate_groups, :roommate_group_id
    add_index :roommate_groups, :applicant_id
    add_index :starred_properties, :applicant_id
    add_index :starred_properties, :rental_offering_id
    add_index :transactions, :applicant_id
    add_index :property_managers, :applicant_id
    add_index :rental_complexes, :property_manager_id
    add_index :invitations, :roommate_group_id
    add_index :profiles, :applicant_id
    add_index :property_photos, :rental_offering_id
  end
end
