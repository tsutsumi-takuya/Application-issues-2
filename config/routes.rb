Rails.application.routes.draw do

  devise_for :users

  root 'home#top'

  get 'home/about' => 'home#about'

  get 'users' => 'users#index'

  resources :books do

  	resource :favorites, only: [:create, :destroy]

  	resources :book_comments, only: [:create, :destroy]

end

  resources :users, only: [:show, :edit, :update]

end