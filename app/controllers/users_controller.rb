class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def search
    @user = User.find_by(username: params[:user_search])
    if @user
      redirect_to posts_path(user: @user.id)
    elsif params[:user_search] == ""
      redirect_to :back
    else
      redirect_to :back, notice: "No results found!"
    end
  end

  def create
    begin
      @user.create(user_params)
      session[:current_user_id] = @user.id
      UserMailer.sign_up_email(@user).deliver_now
      redirect_to posts_path(user: @user.id), notice: "Account successfully created!"
    rescue
      redirect_to new_user_path, alert:
        "Unable to save, please try again. All fields must be filled."
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
