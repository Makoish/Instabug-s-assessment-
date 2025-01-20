class AddTokenFkAndIndexToChats3 < ActiveRecord::Migration[8.0]
  def change
    add_index :chats, :token_fk, name: "index_chats_on_token_fk"
  end
end
