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

  end

end
