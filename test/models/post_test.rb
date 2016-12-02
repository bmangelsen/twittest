require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "can create post" do
    assert Post.new(body: "post", user_id: users(:ben).id)
  end
end
