class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :english_name, null: false
      t.string :ukrainian_name, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
