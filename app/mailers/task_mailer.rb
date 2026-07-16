class TaskMailer < ApplicationMailer
  def due_soon
    @task = params[:task]

    mail(
      to: @task.project.user.email_address,
      subject: "Công việc sắp đến hạn: #{@task.title}"
    )
  end
end
