Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/pokemons/:id", controller: "pokemons", action: "show"
  get "/pokemons", controller: "pokemons", action: "index"
  post "/pokemons", controller: "pokemons", action: "create"
  patch "/pokemons/:id", controller: "pokemons", action: "update"
  delete "/pokemons/:id", controller: "pokemons", action: "destroy"

  post "/users" => "users#create"
  post "/sessions" => "sessions#create"

  get "/unique_pokemons/:id", controller: "unique_pokemons", action: "show"
  get "/unique_pokemons", controller: "unique_pokemons", action: "index"
  post "/unique_pokemons", controller: "unique_pokemons", action: "create"
  post "/unique_pokemons/admin", controller: "unique_pokemons", action: "admin_create"
  patch "/unique_pokemons/:id", controller: "unique_pokemons", action: "update"
  patch "/unique_pokemons/admin/:id", controller: "unique_pokemons", action: "admin_update"
  delete "/unique_pokemons/:id", controller: "unique_pokemons", action: "destroy"

  get "/trainers/:id", controller: "trainers", action: "show"
  get "/trainers", controller: "trainers", action: "index"
  post "/trainers", controller: "trainers", action: "create"
  patch "/trainers/:id", controller: "trainers", action: "update"
  delete "/trainers/:id", controller: "trainers", action: "destroy"
end
