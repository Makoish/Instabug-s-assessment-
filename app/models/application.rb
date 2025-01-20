class Application < ApplicationRecord
    has_many :chats, :foreign_key => :token_fk, :primary_key => :token, :class_name => "Chat"

    
    validates :token, presence: true, uniqueness: true
    validates :application_name, presence: true

    def self.update_chats_count
        chats = Chat.group(:token_fk).count
        chats.each do |token, count|
        application = Application.find_by(token: token)
        application.update(chats_count: count)
        end
    end

    
end
