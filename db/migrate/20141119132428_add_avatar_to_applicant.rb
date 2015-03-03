class AddAvatarToApplicant < ActiveRecord::Migration
  def self.up
    change_table :applicants do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :applicants, :avatar
  end
end
