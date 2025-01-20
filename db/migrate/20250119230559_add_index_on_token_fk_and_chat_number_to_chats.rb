class AddIndexOnTokenFkAndChatNumberToChats < ActiveRecord::Migration[8.0]
  def change
    add_index :chats, [:token_fk, :chat_number], unique: true, name: "index_chats_on_token_fk_and_chat_number"
  end
end
