require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "can get user posts index" do
    new_session(:ben)
    get posts_path
    assert_select "h4", "Here's #{users(:ben).username}'s timeline:"
  end

  test "can get new post view" do
    new_session(:ben)
    get new_post_path
    assert_select "h4", "Enter your post info:"
  end

  test "can create new post" do
    new_session(:ben)
    post posts_path, params: { post: { body: "woop", user_id: users(:ben).id } }
    assert_equal "woop", Post.last.body
  end

  test "can get edit post view" do
    # new_session(:ben)
    # get edit_post_path(posts(:first).id)
    # assert_select "h4", "Edit the "
  end

  test "can update post" do
  end

  test "can delete post" do
  end
end
