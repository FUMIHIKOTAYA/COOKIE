module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def authenticate_user
    redirect_to login_path, notice: 'ログインして始められます。' unless logged_in?
  end

  def logged_user
    redirect_to user_path(current_user.id), notice: 'ログイン済みです。' if logged_in?
  end
end
