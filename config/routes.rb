Rails.application.routes.draw do
  
  

  ActiveAdmin.routes(self)
  root 'pages#index'
  get 'pages/index'
  
  resources :tweets do
    post 'likes', to:"tweets#likes"
    post 'retweets', to:"tweets#retweets"
  end
  devise_for :users
  
  resources :users

  post 'follow/:user_id', to: 'friends#follow', as: 'follow'
  delete 'unfollow/:user_id', to: 'friends#unfollow', as: 'unfollow'

  # RUTAS API
  get 'api/news'
  get 'api/:date_from/:date_to', to: 'api#dates_range'
  post 'api/tweet', to: 'api#create_tweet'
  # post 'api/sign_in', to: 'sessions#create'


  namespace :api, defaults: {format: :json} do
    
      devise_scope :user do
        post "sign_in", to: "sessions#create"
      end
    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
