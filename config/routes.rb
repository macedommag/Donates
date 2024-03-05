Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :institutions do
    resources :donations
  end

  post 'login', to: 'authentication#login'

  get '/test_coinbase_integration', to: 'coinbase_integration#test'
  #get '/donate/:institution_id', to: 'donations#new'
  get '/donate', to: 'donations#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'

end
