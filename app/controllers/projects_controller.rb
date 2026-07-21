class ProjectsController < ApplicationController
    before_action :set_project, only: %i[show edit update destroy]

    def index
        @projects = Current.user.projects.order(created_at: :desc)
    end

    def show
        all_tasks = @project.tasks  

        @total_tasks = all_tasks.count
        @completed_tasks = all_tasks.done.count
        @in_progress_tasks = all_tasks.in_progress.count

        @progress = if @total_tasks.zero?
            0
        else
            ((@completed_tasks.to_f / @total_tasks) * 100).round
        end

        @tasks = all_tasks
            .includes(:comments)
            .with_attached_files
            .order(created_at: :desc)
        if Task.statuses.key?(params[:status])
            @tasks = @tasks.where(status: params[:status])
        end

        if params[:q].present?
            keyword = Task.sanitize_sql_like(params[:q].downcase)
            @tasks = @tasks.where(
                "LOWER(title) LIKE ?",
                "%#{keyword}%"
            )
        end
    end

    def new
        @project = Current.user.projects.new
    end

    def create
        @project = Current.user.projects.new(project_params)

        if @project.save
            redirect_to @project, notice: "Đã tạo dự án"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @project.update(project_params)
            redirect_to @project, notice: "Đã cập nhật dự án."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @project.destroy!
        redirect_to projects_path,
            status: :see_other,
            notice: "Đã xóa dự án."
    end

    private

    def set_project
        @project = Current.user.projects.find(params[:id])
    end

    def project_params
        params.expect(project: %i[name description])
    end
end
