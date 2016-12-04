require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "can get user posts index" do
    new_session(:ben)
    get posts_path(user: users(:ben))
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
    new_session(:ben)
    get edit_post_path(posts(:first).id)
    assert_select "h4", "Update your post's info:"
  end

  test "can update post" do
    new_session(:ben)
    patch post_path(posts(:first).id), params: { post: { body: "updated!" } }
    assert_equal "updated!", Post.find(posts(:first).id).body
  end

  test "can delete post" do
    new_session(:ben)
    delete post_path(posts(:first).id)
    assert_equal 1, Post.count
  end

  test "unauthorized to update post for other user" do
    new_session(:ben)
    assert_raises CanCan::AccessDenied do
      patch post_path(posts(:second).id), params: { post: { body: "updated!" } }
    end
  end

  test "unauthorized to delete post for other user" do
    new_session(:ben)
    assert_raises CanCan::AccessDenied do
      delete post_path(posts(:second).id)
    end
  end

  test "can search for posts and get view" do
    get search_posts_path, params: { post_search: "first" }
    assert_match(/This is first post/, response.body)
    assert_select "h4", "Here's your search results:"
  end

  test "redirect to root path when attempting to access post index without user" do
    get posts_path
    follow_redirect!
    assert_select "h1", "Welcome to Twittest"
  end

  test "redirect to new post view with alert when post doesn't save on create" do
    new_session(:ben)
    post posts_path, params: { post: { body: "", user_id: users(:ben).id } }
    follow_redirect!
    assert flash[:alert]
    assert_select "h4", "Enter your post info:"
  end

  test "redirect to edit post view with alert when post doesn't save on update" do
    new_session(:ben)
    patch post_path(posts(:first).id), params: { post: { body: "" } }
    follow_redirect!
    assert flash[:alert]
    assert_select "h4", "Update your post's info:"
  end
end
