class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.decimal :balance, precision: 10, scale: 2
      t.boolean :admin

      t.timestamps
    end
  end
end
