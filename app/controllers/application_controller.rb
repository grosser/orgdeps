class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate!

  private

  attr_reader :current_user
  helper_method :current_user

  def authenticate!
    unless session[:user_id] && @current_user = User.find_by_id(session[:user_id])
      redirect_to "/auth/github"
    end
  end
end
