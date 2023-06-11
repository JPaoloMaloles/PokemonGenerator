require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # # This is the old authorization test
  # test "create" do
  #   assert_difference "User.count", 1 do
  #     post "/users.json", params: { name: "Test", email: "test@test.com", password: "password", password_confirmation: "password" }
  #     assert_response 201
  #   end
  # end

  test "create" do
    assert_difference "User.count", 1 do
      post "/users", params: { user: { name: "Test", email: "test@email.com", password: "password", password_confirmation: "password" } }
      assert_response 302
    end
    assert_equal User.last.current_trainer_id, Trainer.last.id
  end
end
