class AddUniqueIndexToMembers < ActiveRecord::Migration[5.1]
  def change
    add_index :members, [:user_id, :club_id], unique: true
  end
end
