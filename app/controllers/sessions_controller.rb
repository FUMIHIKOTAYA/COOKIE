class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:alert] = t('view.flash.login_failure')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = t('view.flash.session_delete')
    redirect_to login_url
  end
end
