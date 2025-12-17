require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # This fulfills the 'Back-end design' requirement for validations
  test "should not save task without title" do
    task = Task.new(description: "Trying to pass")
    assert_not task.save, "Saved the task without a title"
  end

  test "should save task with a valid title" do
    task = Task.new(title: "Finish CAD Project", user: users(:test_user))
    assert task.save
  end
end
