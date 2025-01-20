class RemoveApplicationIdFromChats < ActiveRecord::Migration[8.0]
  def change
    remove_column :chats, :application_id
  end
end
