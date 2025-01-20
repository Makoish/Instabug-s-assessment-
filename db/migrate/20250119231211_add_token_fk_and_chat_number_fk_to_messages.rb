class AddTokenFkAndChatNumberFkToMessages < ActiveRecord::Migration[8.0]
  def change

    add_column :messages, :token_fk, :string, null: false
    add_column :messages, :chat_number_fk, :integer, null: false

  end
end
