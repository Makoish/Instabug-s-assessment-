class Message < ApplicationRecord
  searchkick text_middle: [:payload]
  belongs_to :chat, :foreign_key => :chat_number_fk, :primary_key => :chat_number, :class_name => "Chat"
  belongs_to :application, :foreign_key => :token_fk, :primary_key => :token, :class_name => "Application"

  

  def self.create_message_for_chat(chat_number, payload, token) ## Using locks
    Message.transaction do
      
      count = Message.where(chat_number_fk: chat_number).lock.maximum(:message_number)
      if count == nil
        message_obj = { token: token, message_number: 1, chat_number: chat_number, payload: payload}
        message_obj = JSON.parse(message_obj.to_json)
        puts message_obj
        HardJob.perform_async(2, message_obj)
        return 1
      end

      message_number = count + 1
      message_obj = { token: token, message_number: message_number, chat_number: chat_number, payload: payload}
      message_obj = JSON.parse(message_obj.to_json)
      puts message_obj
      HardJob.perform_async(2, message_obj)
      return message_number

    end
  end

  
  

end
