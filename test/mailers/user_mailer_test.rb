require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation_password_reset" do
    mail = UserMailer.account_activation_password_reset
    assert_equal "Account activation password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
