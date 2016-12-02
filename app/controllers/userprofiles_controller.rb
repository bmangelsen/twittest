class UserprofilesController < ApplicationController
  load_and_authorize_resource :class => "User"
  def show
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to userprofile_path
    else
      redirect_to edit_userprofile_path, alert:
        current_user.errors.full_messages.each do |error|
          error
        end
    end
  end

  def edit_password
  end

  def update_password
    binding.pry
    if current_user.update(user_params)
      redirect_to userprofile_path
    else
      redirect_to edit_password_userprofile_path, alert:
        current_user.errors.full_messages.each do |error|
          error
        end
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
