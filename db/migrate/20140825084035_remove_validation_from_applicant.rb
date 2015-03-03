class RemoveValidationFromApplicant < ActiveRecord::Migration
  def change
  	change_column :applicants, :first_name, :string, null: true
  	change_column :applicants, :last_name, :string, null: true
  	change_column :applicants, :born_on, :string, null: true
  	change_column :applicants, :was_ever_evicted, :boolean, null: true
  	change_column :applicants, :is_felon, :boolean, null: true
  end
end
