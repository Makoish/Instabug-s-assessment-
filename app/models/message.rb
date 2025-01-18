class Message < ApplicationRecord
  searchkick text_middle: [:payload]
  belongs_to :chat

  

  
  

end
