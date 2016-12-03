class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.where(username: params[:search])
    if @users.empty?
      begin
        redirect_to :back, notice: "No users found!"
      rescue
        redirect_to root_path, notice: "Especially nope"
      end
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:current_user_id] = @user.id
      redirect_to posts_path(@user.id), notice: "Account successfully created!"
    else
      redirect_to new_user_path, alert:
        @user.errors.full_messages.each do |error|
          error
        end
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
