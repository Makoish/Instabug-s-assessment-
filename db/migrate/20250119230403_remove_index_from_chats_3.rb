class RemoveIndexFromChats3 < ActiveRecord::Migration[8.0]
  def change
    remove_index :chats, name: "index_chats_on_application_id"
    
  end
end
