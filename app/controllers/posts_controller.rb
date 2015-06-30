class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.paginate(:page => params[:page], per_page: 2)
  end

  def new
    @post = Post.new
  end

  def show
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != post_path(@post)
      redirect_to @post, status: :moved_permanently
    end
  end

  def create
    @post = Post.new post_params
    if @post.save
      redirect_to @post, notice: "Your article is saved!"
    else
      render 'new', notice: "Unable to save the post!"
    end
  end

  def edit
  end

  def update
    if @post.update post_params
      redirect_to @post, notice: "Your post was updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :slug)
  end

  def find_post
    @post = Post.friendly.find(params[:id])
  end
end
