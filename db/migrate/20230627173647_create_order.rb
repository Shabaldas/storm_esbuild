class CreateOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.integer :status, default: 0
      t.decimal :subtotal, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.text :comment

      t.timestamps
    end
  end
end
