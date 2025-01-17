class Message < ApplicationRecord
  belongs_to :chat

  # Validations
  validates :message_number, presence: true, uniqueness: true
end
