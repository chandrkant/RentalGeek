class CreateApplicantsRoommateGroups < ActiveRecord::Migration
  def change
    create_table :applicants_roommate_groups do |t|
      t.integer :applicant_id
      t.integer :roommate_group_id
    end
  end
end
