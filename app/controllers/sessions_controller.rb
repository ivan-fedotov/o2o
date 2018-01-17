class SessionsController < ApplicationController
  skip_before_action :get_user
  def new
    render :layout => false
  end

  def create
    @session = safe_params
    @account = Account.find_by_email(@session[:login].downcase)
    @s = nil
    unless @account.nil?
      unless @account.password.active
        redirect_to login_path
      else
        session[:user_id] = @account.id if @account.password.is(@session[:password])
        redirect_to root_path
      end
    else
      redirect_to login_path
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def safe_params
    params.require(:session).permit(:login, :password)

  end
end
