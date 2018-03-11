class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :member, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
