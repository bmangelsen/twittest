require 'test_helper'

class UserprofilesControllerTest < ActionDispatch::IntegrationTest

  test "can get user profile view" do
    new_session(:ben)
    get userprofile_path
    assert_select "h4", "Here's your profile info:"
  end

  test "redirect to new user view when not logged in and accessing profile path" do
    get userprofile_path
    follow_redirect!
    assert_select "p", "Try making a new profile"
    assert_select "h4", "Enter your user info:"
  end

  test "can get edit user view" do
    new_session(:ben)
    get edit_userprofile_path
    assert_select "h4", "Update your Info:"
  end

  test "can edit user" do
    new_session(:ben)
    patch userprofile_path, params: { user: { username: "Ben" } }
    assert_equal "Ben", User.find(users(:ben).id).username
  end

  test "can get edit user password view" do
    new_session(:ben)
    get edit_password_userprofile_path
    assert_select "h4", "Update your password:"
  end

  test "can edit password" do
    new_session(:ben)
    patch edit_password_userprofile_path, params: { user: { password: "haha" } }
    delete session_path
    post session_path, params: { username: "ben", password: "haha" }
    assert_equal users(:ben).id, session["current_user_id"]
  end
end
