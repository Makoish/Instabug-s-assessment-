class AddPayloadToMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :payload, :text
  end
end
