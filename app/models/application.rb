class Application < ApplicationRecord
    has_many :chats

    
    validates :token, presence: true, uniqueness: true
    validates :application_name, presence: true
end
