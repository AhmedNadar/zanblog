class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all.paginate( page: params[:page], per_page: 2)
  end

  def show
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != project_path(@project)
      redirect_to @project, status: :moved_permanently
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if @project.save
      redirect_to @project, notice: "Your project is saved!"
    else
      render 'new', notice: "Unable to save your project!"
    end
  end

  def edit
  end

  def update
    if @project.update project_params
      redirect_to @project, notice: "Your project was updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was deleted!"
  end

  private
  def project_params
    params.require(:project).permit(:title, :description, :link, :slug)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
