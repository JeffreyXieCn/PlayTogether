class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.references :club, foreign_key: true
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :where
      t.decimal :total_cost, precision: 10, scale: 2
      t.integer :status, default: 0

      t.timestamps
    end
  end
end