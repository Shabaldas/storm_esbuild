class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email

      t.timestamps


    end

    add_index :clients, :first_name,         unique: true
    add_index :clients, :last_name,          unique: true
    add_index :clients, :phone_number,       unique: true
  end
end
