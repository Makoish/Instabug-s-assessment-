class RemoveChatIdFromMessages < ActiveRecord::Migration[8.0]
  def change
    remove_column :messages, :chat_id
  end
end
