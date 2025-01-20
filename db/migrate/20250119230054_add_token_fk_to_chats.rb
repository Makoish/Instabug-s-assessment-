class AddTokenFkToChats < ActiveRecord::Migration[8.0]
  def change
    add_column :chats, :token_fk, :string, null: false
    add_foreign_key :chats, :applications, column: :token_fk, primary_key: :token
  end
end
