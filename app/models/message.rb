class Message < ApplicationRecord
  searchkick text_middle: [:payload]
  belongs_to :chat, :foreign_key => :chat_number_fk, :primary_key => :chat_number, :class_name => "Chat"
  belongs_to :application, :foreign_key => :token_fk, :primary_key => :token, :class_name => "Application"

  

  def self.create_message_for_chat(chat_number, payload, token) ## Using locks
    Message.transaction do
      
      count = Message.where(chat_number_fk: chat_number).lock.maximum(:message_number)
      if count == nil
        Message.create(message_number: 1, chat_number_fk: chat_number, payload: payload, token_fk: token)
        return 1
      end

      message_number = count + 1
      Message.create(message_number: message_number, chat_number_fk: chat_number, payload: payload, token_fk: token)
      return message_number

    end
  end

  
  

end
