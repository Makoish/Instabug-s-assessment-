class AddUniqueIndexToChats < ActiveRecord::Migration[8.0]
  def change
    add_index :chats, [:chat_number, :application_id]

  end
end
