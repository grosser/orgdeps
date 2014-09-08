class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate!
  rescue_from ActiveRecord::RecordNotFound do
    render :text => "Not found", :status => :not_found
  end

  private

  attr_reader :current_user
  helper_method :current_user

  def authenticate!
    unless session[:user_id] && @current_user = User.find_by_id(session[:user_id])
      session[:return_to] = request.fullpath
      redirect_to "/auth/github"
    end
  end
end
