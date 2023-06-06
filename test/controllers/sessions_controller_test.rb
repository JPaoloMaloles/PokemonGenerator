require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # # This is the old authorization test
  # test "create" do
  #   post "/users.json", params: { name: "Test", email: "test@test.com", password: "password", password_confirmation: "password" }
  #   post "/sessions.json", params: { email: "test@test.com", password: "password" }
  #   assert_response 201

  #   data = JSON.parse(response.body)
  #   assert_equal ["jwt", "email", "user_id"], data.keys
  # end

  test "create" do
    post "/sessions", params: { email: "test@email.com", password: "password" }
    assert_response 302
  end
end
