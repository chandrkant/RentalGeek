class AddMoveDateAndRoommatesToApplicants < ActiveRecord::Migration
  def change
    
    add_column :applicants, :desires_to_move_in_on, :string
    add_column :applicants, :roommates_description, :text
  end
end

