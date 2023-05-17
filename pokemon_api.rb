# require "poke-api-v2"
# pokemon = PokeApi.get(pokemon: "bulbasaur")
# # puts pokemon.parse(:json)

require "http"
pokemon = HTTP.get("https://pokeapi.co/api/v2/pokemon/bulbasaur/")
puts pokemon.class
puts pokemon.parse(:json)["abilities"]

# villager = HTTP.get("https://pokeapi.co/api/v2/pokemon/bulbasaur/")
# puts pokemon.class
