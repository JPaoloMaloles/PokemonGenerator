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
  
end
