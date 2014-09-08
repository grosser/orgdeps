class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  def create
    user = User.authenticate(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to session.delete(:return_to) || root_url, notice: "Login successful!"
  end

  def destroy
    session[:user_id] = nil
    render :text => %{<html><body>Logged out!<br/><a href="/">Login?</a><body>}
  end
end
