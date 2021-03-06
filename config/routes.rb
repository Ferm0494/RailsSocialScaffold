Rails.application.routes.draw do

   
  

  devise_for :users

  resources :friendships, only: [:index, :show, :destroy,:update]
  post '/friendships/:id' => "friendships#create", as: "new_friendship"
  resources :users, only: [:index, :show] 
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end