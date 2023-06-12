require "test_helper"

class TrainersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(name: "Test", email: "test@email.com", password: "password")
    @trainer = Trainer.create(
      name: "Test Trainer Name",
      title: "Test Title",
      level: 0,
      experience: 0,
      user_id: @user.id,
    )
    @user.update(
      current_trainer_id: @trainer.id,
    )
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
      trainer_id: @user.current_trainer_id,
      pokemon_id: Pokemon.all.sample.id,
    )
    post "/sessions", params: { email: "test@email.com", password: "password" }
  end

  test "show" do
    get "/trainers/#{Trainer.last.id}"
    assert_response 200
  end
end
