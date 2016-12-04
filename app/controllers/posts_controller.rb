class PostsController < ApplicationController
  load_and_authorize_resource
  def new
    @post = Post.new
  end

  def index
    if params[:user]
      @user = User.find(params[:user])
      @per_page = 10.0
      @posts = @posts.limit(@per_page).offset(@per_page * current_page).where(user_id: @user.id).order(created_at: :desc)
    else
      redirect_to root_path
    end
  end

  def search
    if params[:post_search] == ""
      redirect_to :back
    else
      @user = current_user if current_user
      @per_page = 10.0
      @posts = Post.limit(@per_page).offset(@per_page * current_page).search(params[:post_search]).order(created_at: :desc)
      if @posts.empty?
        redirect_to :back, notice: "No results found!"
      end
    end
  end

  def user_total_pages
    (@posts.where(user_id: @user.id).count / @per_page).ceil
  end

  def search_total_pages
    (@posts.search(params[:post_search]).count / @per_page).ceil
  end

  def current_page
    @page = params[:page].to_i
  end

  helper_method :user_total_pages
  helper_method :search_total_pages
  helper_method :current_page

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
