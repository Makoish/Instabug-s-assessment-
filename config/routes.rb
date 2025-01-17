Rails.application.routes.draw do
  # get "app/createApp"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post 'createApp', to: 'app#createApp'
  post 'createChat', to: 'chat#createChat'
  get 'getApp/:name', to: 'app#getApp'
  post 'createMessage', to: 'message#createMessage'
  get 'searchMessage', to: 'message#searchMessage'
  

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
