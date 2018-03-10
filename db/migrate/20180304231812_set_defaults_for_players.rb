class SetDefaultsForPlayers < ActiveRecord::Migration[5.1]
  def change
    change_column_default :players, :cost, 0
  end
end
