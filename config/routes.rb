Rails.application.routes.draw do
  # get "app/createApp"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post 'api/applications', to: 'app#createApp'
  get 'api/applications/:token', to: 'app#getAppName'
  get 'api/applications/:token/chatCount', to: 'app#getCount' ## gets the chat count for a given app
  put 'api/applications/:token', to: 'app#updateApp' ## updates the name of the applicaation
  get 'api/applications/:token/chats', to: 'app#allChat'
  delete 'api/applications/:token', to: 'app#deleteApp'


  # elastic searach is not applied here.
  # it's applied on messages' routes
  post 'api/chats/:token', to: 'chat#createChat'
  delete 'api/chats/:token/:chat_number', to: 'chat#deleteChat'
  
  

  post 'api/message/:token/:chat_number', to: 'message#createMessage'
  get 'api/message/:token/:chat_number/searchMessage', to: 'message#searchMessage' ## Using elastic search matching phrase, "love" would match "I love programming"
  delete 'api/messages/message/:token/:message_number/:chat_number', to: 'message#deleteMessage'

  
  

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
