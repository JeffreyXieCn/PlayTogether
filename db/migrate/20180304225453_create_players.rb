class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.references :user, foreign_key: true
      t.references :activity, foreign_key: true
      t.decimal :cost, precision: 10, scale: 2

      t.timestamps
    end
  end
end
