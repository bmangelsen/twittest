class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:current_user_id] = @user.id
      redirect_to posts_path(@user.id), notice: "Login victory!"
    else
      redirect_to root_path, alert: "You input something wrong..."
    end
  end
end
