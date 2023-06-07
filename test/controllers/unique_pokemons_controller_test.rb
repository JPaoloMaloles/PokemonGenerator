require "test_helper"

class UniquePokemonsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = User.create(name: "Test", email: "test@email.com", password: "password")
    @test_pokemon = UniquePokemon.create!(
      nickname: "nickname",
      nature: "nature",
      shiny: "shiny",
      gender: "gender",
      hp_ev: 3,
      atk_ev: 3,
      defe_ev: 3,
      spa_ev: 3,
      spd_ev: 3,
      spe_ev: 3,
      hp_iv: 3,
      atk_iv: 3,
      defe_iv: 3,
      spa_iv: 3,
      spd_iv: 3,
      spe_iv: 3,
      user_id: @user.id,
      pokemon_id: Pokemon.all.sample.id,
    )
    post "/sessions", params: { email: "test@email.com", password: "password" }
  end

  test "show" do
    # puts "all pokemon are: #{UniquePokemon.first.id} and #{UniquePokemon.last.id}"
    # puts "There user id's are: #{UniquePokemon.first.user_id} and #{UniquePokemon.last.user_id}"
    # puts "the user's id: #{@user.id}"
    # puts "the test pokemon's id: #{@test_pokemon.id}"
    # puts "The last pokemon's id: #{UniquePokemon.last.id}"
    get "/unique_pokemons/#{UniquePokemon.last.id}"
    assert_response 200

    # puts unique_pokemons(:one)
    get "/unique_pokemons/#{UniquePokemon.last.id}.json"
    unique_pokemon_hash = JSON.parse(response.body)
    assert_equal ["id",
                  "nickname",
                  "nature",
                  "shiny",
                  "gender",
                  "hp_ev",
                  "atk_ev",
                  "defe_ev",
                  "spa_ev",
                  "spd_ev",
                  "spe_ev",
                  "hp_iv",
                  "atk_iv",
                  "defe_iv",
                  "spa_iv",
                  "spd_iv",
                  "spe_iv",
                  "user_id",
                  "pokemon_id",
                  "pokemon"], unique_pokemon_hash.keys
  end

  test "create" do
    assert_difference "UniquePokemon.count", 1 do
      post "/unique_pokemons", params: { unique_pokemon: {
                                 nickname: "test_name",
                                 nature: "test_nature",
                                 shiny: true,
                               } }
      assert_response 302
    end
  end
end
