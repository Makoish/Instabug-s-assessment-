class AddNonUniqueIndexToChats < ActiveRecord::Migration[8.0]
  def change
    add_index :chats, [:chat_number, :application_id], name: "index_chats_on_chat_number_and_application_id"
  end
end
