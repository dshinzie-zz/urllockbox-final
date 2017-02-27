Rails.application.routes.draw do

  root to: "links#index"

  resources :links, only: [:index, :create]
  resources :users, only: [:new, :create]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create, :update]
    end
  end
end
