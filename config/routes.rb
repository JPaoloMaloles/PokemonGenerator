Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/" => "pokemons#index"

  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/login" => "sessions#new"
  post "/sessions" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/change_trainer" => "users#change_current_trainer"

  resources :pokemons
  resources :unique_pokemons
  post "/unique_pokemons/admin", controller: "unique_pokemons", action: "admin_create"
  get "/instant_pokemon" => "unique_pokemons#instant_create_unique_pokemon"
  patch "/unique_pokemons/admin/:id", controller: "unique_pokemons", action: "admin_update"
  resources :trainers
  resources :teams
  resources :pokemon_in_teams
  # post "/pokemon_in_teams/new_direct", controller: "pokemon_in_teams", action: "new_direct"
end
