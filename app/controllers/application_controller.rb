class ApplicationController < ActionController::Base

  add_flash_types(:danger)

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to signin_path, alert: "You need to be signed in to access this page."
    end
  end

  def require_correct_user
    @user = User.find_by!(username: params[:id])
    redirect_to root_url, alert: "You don't have access to that page." unless current_user?(@user)
  end

  def require_admin
    unless current_user.admin?
      redirect_to movies_url, alert: "Unauthorized access."
    end
  end

end
