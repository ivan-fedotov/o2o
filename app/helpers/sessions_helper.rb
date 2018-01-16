module SessionsHelper


  def get_user
    if session[:user_id].nil?
      redirect_to login_path
    else
      a = Account.find(session[:user_id])
      redirect_to login_path if a.nil?
    end
  end

  def is_root
    unless current_user.is_root
      render :file => 'public/404.html', :status => :not_found, :layout => false
    end
  end

  def current_user
    @current_user ||= Account.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

end
