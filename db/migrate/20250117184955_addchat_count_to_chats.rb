class AddchatCountToChats < ActiveRecord::Migration[8.0]
  def change
    add_column :applications, :chats_count, :integer
    add_column :chats, :messages_count, :integer
  end
end
