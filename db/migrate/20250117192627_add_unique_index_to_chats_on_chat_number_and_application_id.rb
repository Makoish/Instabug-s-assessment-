class AddUniqueIndexToChatsOnChatNumberAndApplicationId < ActiveRecord::Migration[8.0]
  def change
    add_index :chats, [:application_id, :chat_number], unique: true
  end
end
