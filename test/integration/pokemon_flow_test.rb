require "test_helper"

class PokemonFlowTest < ActionDispatch::IntegrationTest
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

  test "test homepage to pokemon index" do
    get "/"
    assert_select "h1", "Hello pokemon"
  end

  test "can create an unique pokemon" do
    get "/unique_pokemons/new"
    assert_response :success

    post "/unique_pokemons",
      params: { unique_pokemon: {
        nickname: "test_name",
        nature: "test_nature",
        shiny: true,
      } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    # assert_select "p", "Title:\n  can create"
  end
end
