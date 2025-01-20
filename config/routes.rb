Rails.application.routes.draw do
  # get "app/createApp"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post 'api/applications/createApp', to: 'app#createApp'
  get 'api/applications/:token/chatCount', to: 'app#getCount' ## gets the chat count for a given app
  put 'api/applications/:token/updateApp', to: 'app#updateApp' ## updates the name of the applicaation


  post 'api/chats/:token/createChat', to: 'chat#createChat'
  post 'api/message/:token/createMessage', to: 'message#createMessage'
  
  get 'api/message/searchMessage', to: 'message#searchMessage' ## Using elastic search matching phrase, "love" would match "I love programming"
  get 'api/applications/messageCount', to: 'message#getCount' ## BRB

  delete 'api/messages/message/:token/:message_number/:chat_number', to: 'message#deleteMessage'

  
  

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
