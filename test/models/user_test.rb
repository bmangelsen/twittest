require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "can create user" do
    assert User.create(username: "Joe", email: "joe@joe.com", password: "joe")
  end
end
