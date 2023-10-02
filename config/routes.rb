Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'pages#home'

  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  get 'profil', to: 'pages#profil', as: 'profil'
  get 'friends_list', to: 'pages#friends_list', as: 'friends'
  get 'settings', to: 'pages#settings', as: 'settings'

  resources :books, only: %i[show] do
    resources :user_books, only: %i[create update destroy] do
      post :archive
    end
    resources :reviews, only: %i[new create]
    collection do
      get :search
      get :reading_list
      get :wish_list
      get :read_list
    end
  end

  resources :users, only: %i[show] do
    resources :friendships, only: %i[create]
  end

  resources :friendships, only: %i[update destroy] do
    member do
      patch :reject
    end
  end
end
