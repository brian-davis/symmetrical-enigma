class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def unrecognized_login
    @user = params[:user]
    @password_reset_url = params[:password_reset_url]
    mail(to: @user.email, subject: 'Unrecognized Login')
  end
end
