Rails.application.routes.draw do
  resources :inventories
  resources :markets
  resources :items
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/my_market', to: 'markets#my_market'
end
