class Changedatatype < ActiveRecord::Migration
  def change
    change_column :co_signers, :zip_code, :string
    change_column :co_signers, :phone, :string
    change_column :co_signers, :rent_mortage, 'integer USING CAST(rent_mortage AS integer)'
    change_column :co_signers, :a_source_income, :string
    change_column :co_signers, :spouse_additional_source_income, :string
  end
end
