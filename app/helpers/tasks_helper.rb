module TasksHelper
  def task_status_label(task)
    {
      "todo" => "Cần làm",
      "in_progress" => "Đang thực hiện",
      "done" => "Hoàn thành"
    }.fetch(task.status)
  end

  def task_status_class(task)
    {
      "todo" => "badge--todo",
      "in_progress" => "badge--progress",
      "done" => "badge--done"
    }.fetch(task.status)
  end

  def task_due_label(task)
    return "Không có deadline" if task.due_on.blank?
    return "Quá hạn #{time_ago_in_words(task.due_on)}" if task.overdue?
    return "Hôm nay" if task.due_on.today?
    return "Ngày mai" if task.due_on == Date.tomorrow

    "Hạn #{l(task.due_on)}"
  end

  def task_due_class(task)
    task.overdue? ? "task-meta--danger" : ""
  end
end