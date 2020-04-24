Rails.application.routes.draw do

  devise_for :users

  root 'home#top'

  get 'home/about' => 'home#about'

  get 'users' => 'users#index'

  resources :books do

  	resource :favorites, only: [:create, :destroy]

  	resources :book_comments, only: [:create, :destroy]

end

  resources :users do

        member do
            get :following, :followers
        end
    end

  resources :users, only: [:show, :edit, :update]

  resources :relationships, only: [:create, :destroy]

end