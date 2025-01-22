class Chat < ApplicationRecord
  belongs_to :application, :foreign_key => :token_fk, :primary_key => :token, :class_name => "Application"
  has_many :messages, :foreign_key => :chat_number_fk, :primary_key => :chat_number, :class_name => "Message", dependent: :destroy


  def self.update_messages_count
      messages = Message.group(:chat_number_fk).count
      messages.each do |chat_number_fk, count|
      chat = Chat.find_by(chat_number: chat_number_fk)
      chat.update(messages_count: count)
      end
  end
 
  def self.create_chat_for_application(app_id, token)
    Chat.transaction do
      count = Chat.where(token_fk: token).lock.maximum(:chat_number)
      if count == nil
        chat_obj = { token: token, chat_number: 1}
        chat_obj = JSON.parse(chat_obj.to_json)
        chat = HardJob.perform_async(1, chat_obj)
        return 1
      end
      chat_number = count + 1
      chat_obj = { token: token, chat_number: chat_number}
      chat_obj = JSON.parse(chat_obj.to_json)
      chat = HardJob.perform_async(1, chat_obj)
      return chat_number
    end
  end


  
    
end


