class DailyDueReminderJob < ApplicationJob
  queue_as :default

  def perform
    Task
      .where(due_on: Date.tomorrow)
      .where.not(status: Task.statuses[:done])
      .find_each do |task|
        TaskMailer.with(task: task).due_soon.deliver_later
      end
  end
end
