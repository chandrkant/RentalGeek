class CreateCoSign < ActiveRecord::Migration
  def change
    create_table :co_signs do |t|
    	t.integer	:co_signer_id
    	t.integer	:apply_id
    	t.string	:cosigning_for
    	t.string	:relationship
    	t.date		:signature_date

    	t.timestamps
    end
  end
end
