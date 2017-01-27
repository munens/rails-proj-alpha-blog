class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in

  def current_user
    # finds our current user: - if he already exists. If he does not exist then 
    # return the user from the session
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # '!!' is used in order to change any value to a boolean - in this case if there 
    # is a current user available.
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end  
  end 
end
