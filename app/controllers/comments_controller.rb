class CommentsController < ApplicationController
  before_action :set_project
  before_action :set_task

  def create
    @comment = @task.comments.new(
      comment_params.merge(user: Current.user)
    )

    if @comment.save
      redirect_to [@project, @task], notice: "Đã thêm bình luận."
    else
      redirect_to [@project, @task],
        alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    comment = @task.comments.find(params[:id])
    comment.destroy!

    redirect_to [@project, @task],
      status: :see_other,
      notice: "Đã xóa bình luận."
  end

  private

  def set_project
    @project = Current.user.projects.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:task_id])
  end

  def comment_params
    params.expect(comment: [:body])
  end
end