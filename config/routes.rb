Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "pages#home"

  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'

  resources :books, only: %i[show] do
    resources :reviews, only: %i[new create]
    collection do
      get :search
      get :reading_list
      get :wish_list
      get :read_list
    end
  end
end
