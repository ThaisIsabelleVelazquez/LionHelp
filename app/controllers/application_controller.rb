class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    current_user = UserAccount.find_by(name: session[:user_name])
    unless current_user
      flash[:warning] = "Please log in to access the app."
      redirect_to accounts_path
    end
  end
end
