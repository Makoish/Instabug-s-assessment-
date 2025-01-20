class Chat < ApplicationRecord
  belongs_to :application, :foreign_key => :token_fk, :primary_key => :token, :class_name => "Application"
  has_many :messages


  def self.update_messages_count
      messages = Message.group(:chat_number_fk).count
      messages.each do |chat_number_fk, count|
      chat = Chat.find_by(chat_number: chat_number_fk)
      chat.update(messages_count: count)
      end
  end
 
  def self.create_chat_for_application(app_id, token)
    Chat.transaction do
      chats = Chat.where(token_fk: token).lock
      chat_number = chats.count + 1
      chat = Chat.create(chat_number: chat_number, token_fk: token, messages_count: 0)
      return chat_number
    end
  end


  
    
end


