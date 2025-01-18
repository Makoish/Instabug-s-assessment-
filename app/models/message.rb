class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :chat

  mappings dynamic: 'false' do
    indexes :payload, type: 'text', analyzer: 'standard'
  end

  
  

end
