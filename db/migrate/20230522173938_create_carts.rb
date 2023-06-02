class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.string :token

      t.timestamps
    end
    add_index :carts, :token, unique: true
  end
end
