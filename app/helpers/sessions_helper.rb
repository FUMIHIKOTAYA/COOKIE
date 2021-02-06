module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def authenticate_user
    redirect_to new_session_path, notice: 'ログインして始められます。' unless logged_in?
  end

end
