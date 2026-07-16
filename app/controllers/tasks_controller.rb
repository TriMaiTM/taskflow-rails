class TasksController < ApplicationController
    before_action :set_project
    before_action :set_task, only: %i[show edit update destroy toggle]

    def index   
        @tasks = filtered_tasks
    end

    def show
    end

    def new
        @task = @project.tasks.new
    end

    def create
        @task = @project.tasks.new(task_params)
        if @task.save
            redirect_to [@project, @task], notice: "Đã tạo công việc."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
            redirect_to [@project, @task], notice: "Đã cập nhật công việc"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @task.destroy!
        redirect_to @project,
        status: :see_other,
        notice: "Đã xóa công việc"
    end

    def toggle
        new_status = @task.done?? :todo : :done
        @task.update!(status: new_status)
        redirect_to @project, status: :see_other
    end

    def set_project
        @project = Current.user.projects.find(params[:project_id])
    end

    def set_task
        @task = @project.tasks.find(params[:id])
    end

    def filtered_tasks
        tasks = @project.tasks.recent_first
        if Task.statuses.key?(params[:status])
            tasks = tasks.where(status: params[:status])
        end

        if params[:q].present?
            keyword = Task.sanitize_sql_like(params[:q].downcase)
            tasks = tasks.where("LOWER(title) LIKE ?", "%#{keyword}%")
        end

        tasks
    end

    def task_params
        params.expect(
            task: [
                :title,
                :description,
                :status,
                :due_on,
                { files: [] }
            ]
        )
    end
end
