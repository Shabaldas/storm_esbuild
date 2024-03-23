class RemoveUniqueConstraintFromClientsPhoneNumber < ActiveRecord::Migration[7.0]
  def change
    remove_index :clients, :phone_number
    add_index :clients, :phone_number
  end
end
