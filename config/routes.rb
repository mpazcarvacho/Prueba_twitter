Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/index'
  
  resources :tweets do
    post 'likes', to:"tweets#likes"
    post 'retweets', to:"tweets#retweets"
  end
  devise_for :users
  
  resources :users
  post 'follow/:user_id', to: 'users#follow', as: 'follow'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
