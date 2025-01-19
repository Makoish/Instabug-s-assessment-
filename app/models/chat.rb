class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages



  def self.update_messages_count
      messages = Message.group(:chat_id).count
      messages.each do |id, count|
      chat = Chat.find(id)
      chat.update(messages_count: count)
  end

    
  end
end
