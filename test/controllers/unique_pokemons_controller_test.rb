require "test_helper"

class UniquePokemonsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = User.create(name: "Test", email: "test@email.com", password: "password")
    post "/sessions", params: { email: "test@email.com", password: "password" }
  end

  # test "create" do
  #   # write here code to assume User is installed
  #   #authenticate_user = true

  #   assert_difference "UniquePokemon.count", 1 do
  #     post "/unique_pokemons", params: { unique_pokemon: {
  #                                nickname: "test_name",
  #                                nature: "test_nature",
  #                                #  gender: "a",
  #                                shiny: true,
  #                              #  hp_ev: 1,
  #                              #  atk_ev: 1,
  #                              #  defe_ev: 1,
  #                              #  spa_ev: 1,
  #                              #  spd_ev: 1,
  #                              #  spe_ev: 1,
  #                              #  hp_iv: 1,
  #                              #  atk_iv: 1,
  #                              #  defe_iv: 1,
  #                              #  spa_iv: 1,
  #                              #  spd_iv: 1,
  #                              #  spe_iv: 1,
  #                              #  user_id: 1,
  #                              #  pokemon_id: 1,
  #                              } }
  #     # assert_response 302
  #   end
  # end
end
