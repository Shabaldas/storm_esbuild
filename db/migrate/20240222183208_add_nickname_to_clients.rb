class AddNicknameToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :nickname, :string
    add_index :clients, :nickname
  end
end
