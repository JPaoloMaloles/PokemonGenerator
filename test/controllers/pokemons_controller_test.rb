require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "show" do
    #puts "this is: #{Pokemon.first.id}"
    get "/pokemons/#{Pokemon.first.id}"
    assert_response 200

    # get "/pokemons/#{Pokemon.first.id}.json"
    # pokemon_hash = JSON.parse(response.body)
    # assert_equal ["national_dex_num",
    #               "name",
    #               "first_type",
    #               "second_type",
    #               "abilities",
    #               "hp",
    #               "atk",
    #               "defe",
    #               "spa",
    #               "spd",
    #               "spe",
    #               "url",
    #               "icon",
    #               "first_type_image",
    #               "second_type_image"], pokemon_hash.keys
  end

  test "index" do
    get "/pokemons"
    assert_response 200

    get "/pokemons.json"
    pokemons_hash = JSON.parse(response.body)
    assert_equal Pokemon.count, pokemons_hash.length
  end
end
