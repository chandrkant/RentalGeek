class AddAgreementAttributeToApply < ActiveRecord::Migration
  def change
    add_column :applies, :custom_agreement, :boolean, :default => false
    add_column :applies, :agreement_status, :string
    add_column :applies, :agreement_guid, :string
    add_column :applies, :agreement_url, :string
  end
end
