class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.references :payment_category
      t.float :amount, precision: 10, scale: 2, null: false
      t.date :date, null: false, index: true
      t.boolean :deleted, default: false
      t.timestamps
    end
  end
end
