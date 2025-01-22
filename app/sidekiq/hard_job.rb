class HardJob
  include Sidekiq::Job

  def perform(object_id, obj)
    
    
    if object_id == 1
      Chat.create(token_fk: obj["token"], chat_number: obj["chat_number"], messages_count: 0)
    else
      Message.create(token_fk: obj["token"], chat_number_fk: obj["chat_number"], payload: obj["payload"], message_number: obj["message_number"])
    end
  end

end
