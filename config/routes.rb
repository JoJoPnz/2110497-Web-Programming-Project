Rails.application.routes.draw do
  resources :inventories
  resources :markets
  resources :items
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/login', to: "main#login"
  post 'main/create'
  get '/profile', to: "main#profile"
  post '/edit_password', to: "main#edit_password"
  get '/edit_password', to: "main#edit_password"
  get '/main', to: "main#menu"
  # Defines the root path route ("/")
  # root "articles#index"
end
