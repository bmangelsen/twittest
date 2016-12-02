class PostsController < ApplicationController
  load_and_authorize_resource
  def new
    @post = Post.new
  end

  def index
    @user = current_user
    @posts = @posts.where(user_id: @user.id).order(created_at: :desc)
  end

  def create
    @post = Post.new(post_params)
    @user = current_user

    if @post.save
      redirect_to posts_path(@user.id), notice: "Post successfully created!"
    else
      redirect_to new_post_path, alert:
        @post.errors.full_messages.each do |error|
          error
        end
    end
  end

  private
  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
