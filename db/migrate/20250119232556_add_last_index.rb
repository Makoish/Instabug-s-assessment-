class AddLastIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :messages, [:chat_number_fk], name: 'index_messages_on_chat_number'
  end
end
