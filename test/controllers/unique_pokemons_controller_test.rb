require "test_helper"

class UniquePokemonsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = User.create(name: "Test", email: "test@email.com", password: "password")
    post "/sessions", params: { email: "test@email.com", password: "password" }
  end

  test "create" do
    # write here code to assume User is installed
    #authenticate_user = true

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
