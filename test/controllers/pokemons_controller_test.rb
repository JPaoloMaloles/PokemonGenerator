require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "index" do
    get "/pokemons"
    assert_response 200

    get "/pokemons.json"
    pokemons_hash = JSON.parse(response.body)
    assert_equal Pokemon.count, pokemons_hash.length
  end
end
