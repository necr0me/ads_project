class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user.present? && user.authenticate(params[:session][:password])
      # Осуществить вход пользователя и перенаправление на страницу профиля.
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      # Выдать сообщение об ошибке.
      flash.now[:danger] = 'Invalid email/password combination' # Не совсем верно!
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
