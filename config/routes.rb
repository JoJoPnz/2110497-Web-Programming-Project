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
  get '/my_inventory', to: "markets#my_inventory"
  post '/delete_item', to: "markets#delete_item"
  get '/my_market', to: 'markets#my_market'
  post "/inventory_edit_item", to: 'markets#inventory_edit_item'
  get '/inventory_add_item', to: "markets#inventory_add_item"
  post "/disable_item", to: "markets#disable_item"
  post '/purchase_item', to: 'markets#purchase_item'

  # /purchase_history page
  get '/purchase_history', to: 'inventories#purchase_history'

  # /sale_history page
  get '/sale_history', to: 'inventories#sale_history'

end
