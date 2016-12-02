require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "can get session new view" do
    get root_path
    assert_select "h1", "Welcome to Twittest"
  end

  test "can create session" do
    new_session(:ben)
    assert_equal users(:ben).id, session["current_user_id"]
  end

  test "can delete session" do
    new_session(:ben)
    delete session_path
    assert_nil session["current_user_id"]
  end

  test "render root view when fail to login" do
    post session_path, params: { user: { username: "Joe" } }
    assert_select "h1", "Welcome to Twittest"
  end
end
