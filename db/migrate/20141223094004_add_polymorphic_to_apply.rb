class AddPolymorphicToApply < ActiveRecord::Migration
  def change
    rename_column :applies, :applicant_id, :applicable_id
    add_column :applies, :applicable_type, :string
  end
end
