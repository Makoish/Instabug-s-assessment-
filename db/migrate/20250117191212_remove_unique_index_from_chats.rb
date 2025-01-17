class RemoveUniqueIndexFromChats < ActiveRecord::Migration[8.0]
  def change
    remove_index :chats, name: "index_chats_on_chat_number_and_application_id"
  end
end
