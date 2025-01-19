class Application < ApplicationRecord
    has_many :chats

    
    validates :token, presence: true, uniqueness: true
    validates :application_name, presence: true



    def self.update_chats_count
        chats = Chat.group(:application_id).count
        
        chats.each do |id, count|
        application = Application.find(id)
        application.update(chats_count: count)
        end
    end
end
