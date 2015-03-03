class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.boolean :status, default: false
      t.references :roommate_group
      t.timestamps
    end
  end
end
