class CreateRoommateGroups < ActiveRecord::Migration
  def change
    create_table :roommate_groups do |t|
      t.string :name
      t.references :applicant
      t.timestamps
    end
  end
end
