Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/" => "pokemons#index"

  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/login" => "sessions#new"
  post "/sessions" => "sessions#create"
  get "/logout" => "sessions#destroy"

  resources :pokemons
  resources :unique_pokemons
  post "/unique_pokemons/admin", controller: "unique_pokemons", action: "admin_create"
  patch "/unique_pokemons/admin/:id", controller: "unique_pokemons", action: "admin_update"
  resources :trainers
  resources :teams
  resources :pokemon_in_teams
end
