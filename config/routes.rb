Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'

  resources :institutions, only: [:index]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'
end
