Rails.application.routes.draw do

  devise_for :users

  root 'home#top'

  get 'home/about' => 'home#about'

  get 'users' => 'users#index'

  resources :books

  resources :users, only: [:show, :edit, :update]
end