require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "can get new user view" do
    get new_user_path
    assert_select "h4", "Enter your user info:"
  end

  test "can create new user" do
    post users_path, params: { user: { username: "joe", email: "joe@joe.com", password: "password", password_confirmation: "password" } }
    assert_equal "joe", User.last.username
  end

  # test "render new user view with alert when fail to create" do
  #   post users_path, params: { user: { username: "joe", password: "password", password_confirmation: "password" } }
  #   follow_redirect!
  #   assert flash[:alert]
  #   assert_select "h4", "Enter your user info:"
  # end

  test "can get user post index on search" do
    get search_users_path, params: { user_search: "ben" }
    follow_redirect!
    assert_select "h4", "Here's ben's timeline:"
  end
end
