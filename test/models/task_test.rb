require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "title is required" do
    task = Task.new(project: projects(:one), title: "")
    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "completed task is not overdue" do
    task = tasks(:done)
    assert task.done?
    assert_not task.overdue?
  end

  test "unfinished task with past deadline is overdue" do
    task = tasks(:todo)
    task.due_on = Date.yesterday
    assert task.overdue?
  end
end
