class AddIndexToActivities < ActiveRecord::Migration[5.1]
  def change
    add_index :activities, [:club_id, :start_time]
  end
end
