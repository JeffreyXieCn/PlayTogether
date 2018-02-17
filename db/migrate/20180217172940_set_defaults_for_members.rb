class SetDefaultsForMembers < ActiveRecord::Migration[5.1]
  def change
    change_column_default :members, :balance, 0
    change_column_default :members, :admin, false
  end
end
