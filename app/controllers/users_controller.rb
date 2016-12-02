class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:current_user_id] = @user.id
      # UserMailer.sign_up_email(@user).deliver_now
      redirect_to posts_path(@user.id)
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
