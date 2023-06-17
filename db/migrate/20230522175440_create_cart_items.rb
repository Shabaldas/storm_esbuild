class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.belongs_to :cart, null: false, foreign_key: true
      t.references :cartable, polymorphic: true, null: false
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
