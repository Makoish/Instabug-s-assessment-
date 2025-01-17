class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages

  # Validations
end
