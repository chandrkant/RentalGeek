class AddApplicantIdToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :applicant_id, :integer
  end
end
