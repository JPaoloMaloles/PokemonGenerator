Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/" => "pokemons#index"
  # Defines the root path route ("/")
  # root "articles#index"
  get "/pokemons/:id", controller: "pokemons", action: "show"
  get "/pokemons", controller: "pokemons", action: "index"
  post "/pokemons", controller: "pokemons", action: "create"
  patch "/pokemons/:id", controller: "pokemons", action: "update"
  delete "/pokemons/:id", controller: "pokemons", action: "destroy"

  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/login" => "sessions#new"
  post "/sessions" => "sessions#create"
  get "/logout" => "sessions#destroy"

  resources :unique_pokemons
  # get "/unique_pokemons/:id", controller: "unique_pokemons", action: "show"
  # get "/unique_pokemons", controller: "unique_pokemons", action: "index"
  # get "/unique_pokemons", controller: "unique_pokemons", action: "new", as: "new_unique_pokemon"
  # post "/unique_pokemons", controller: "unique_pokemons", action: "create"
  # post "/unique_pokemons/admin", controller: "unique_pokemons", action: "admin_create"
  # patch "/unique_pokemons/:id", controller: "unique_pokemons", action: "update"
  # patch "/unique_pokemons/admin/:id", controller: "unique_pokemons", action: "admin_update"
  # delete "/unique_pokemons/:id", controller: "unique_pokemons", action: "destroy"

  get "/trainers/:id", controller: "trainers", action: "show"
  get "/trainers", controller: "trainers", action: "index"
  post "/trainers", controller: "trainers", action: "create"
  patch "/trainers/:id", controller: "trainers", action: "update"
  delete "/trainers/:id", controller: "trainers", action: "destroy"

  get "/teams/:id", controller: "teams", action: "show"
  get "/teams", controller: "teams", action: "index"
  post "/teams", controller: "teams", action: "create"
  patch "/teams/:id", controller: "teams", action: "update"
  delete "/teams/:id", controller: "teams", action: "destroy"

  get "/pokemon_in_teams/:id", controller: "pokemon_in_teams", action: "show"
  get "/pokemon_in_teams", controller: "pokemon_in_teams", action: "index"
  post "/pokemon_in_teams", controller: "pokemon_in_teams", action: "create"
  patch "/pokemon_in_teams/:id", controller: "pokemon_in_teams", action: "update"
  delete "/pokemon_in_teams/:id", controller: "pokemon_in_teams", action: "destroy"
end
