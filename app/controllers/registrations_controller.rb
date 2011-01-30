class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    @user.nick = params[:user][:nick]
    @user.email_alert = false
    @user.sms_alert = false
    @user.weekend = false
    @user.save
  end

  def update
    super
  end
end 