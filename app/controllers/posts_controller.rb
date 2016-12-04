class PostsController < ApplicationController
  load_and_authorize_resource
  def new
    @post = Post.new
  end

  def index
    if params[:user]
      @user = User.find(params[:user])
      @posts = @posts.where(user_id: @user.id).order(created_at: :desc)
    else
      redirect_to root_path
    end
  end

  def search
    if params[:post_search] == ""
      redirect_to :back
    else
      @user = current_user if current_user
      @posts = Post.search(params[:post_search])
      if @posts.empty?
        redirect_to :back, notice: "No results found!"
      end
    end
  end

  def create
    @post = Post.new(post_params)
    @user = current_user

    if @post.save
      redirect_to posts_path(user: @user.id), notice: "Post successfully created!"
    else
      redirect_to new_post_path, alert:
        @post.errors.full_messages.each do |error|
          error
        end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path(user: current_user)
    else
      redirect_to edit_post_path(@post.id), alert:
        @post.errors.full_messages.each do |error|
          error
        end
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path(user: current_user), notice: "Successfully deleted"
  end

  private
  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
