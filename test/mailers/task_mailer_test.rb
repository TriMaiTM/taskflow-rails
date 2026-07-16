require "test_helper"

class TaskMailerTest < ActionMailer::TestCase
  test "due_soon" do
    mail = TaskMailer.due_soon
    assert_equal "Due soon", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
