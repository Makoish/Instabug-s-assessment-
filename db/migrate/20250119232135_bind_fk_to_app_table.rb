class BindFkToAppTable < ActiveRecord::Migration[8.0]
  def change

    add_foreign_key :messages, :applications, column: :token_fk, primary_key: :token
    add_foreign_key :messages, :chats, column: :chat_number_fk, primary_key: :chat_number
    add_index :messages, [:token_fk, :chat_number_fk, :message_number], unique: true, name: 'index_messages_on_token_fk_chat_number_fk_and_message_number'
    add_index :messages, [:chat_number_fk], name: 'index_messages_on_chat_number'

    

  end
end
