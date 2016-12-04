require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "mailer" do
    mail = UserMailer.sign_up_email(users(:ben))
    assert_equal "May your procrastination be great", mail.subject
    assert_match "ben", mail.body.encoded
  end
end
