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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
