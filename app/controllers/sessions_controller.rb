class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:current_user_id] = @user.id
      redirect_to posts_path(@user.id), notice: "Login victory!"
    else
      redirect_to new_session_path, alert: "You input something wrong..."
    end
  end

  def destroy
    session.delete("current_user_id")
    redirect_to root_path
  end
end
