class UserMailer < ApplicationMailer
  def sign_up_email(user)
    @user = user
    mail(
      to: user.email,
      subject: 'May your procrastination be great'
    )
  end
end
