class AddRefsToMembers < ActiveRecord::Migration[5.1]
  def change
    add_reference :members, :user, foreign_key: true
    add_reference :members, :club, foreign_key: true
  end
end
