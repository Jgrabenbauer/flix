Rails.application.routes.draw do



  root "movies#index"

  resources :genres

  resource :session, only: [:new, :create, :destroy]

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  resources :users

  get "signup" => "users#new"
  get "signin" => "sessions#new"

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies

end
