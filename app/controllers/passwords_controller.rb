class PasswordsController < ApplicationController
  before_action :get_permissions, only: [:new, :switch]

  def new
    @password = Account.find(params[:account_id]).password
  end

  def update
    @password = Account.find(params[:account_id]).password
    if @password.set_password( safe_params[:secret] )
      if @password.account == Current.user
        redirect_to profile_path, :notice => "Password changed"
      else
        redirect_to accounts_path
      end
    else
      render :new
    end
  end

  def switch
    @password = Account.find(params[:account_id]).password
    unless @password.secret.nil?
      @password.active = @password.active ? false : true
      @password.save
    end
    redirect_to accounts_path
  end

  private

  def safe_params
    params.require(:password).permit(:secret)
  end

  def get_permissions
    raise ActionController::RoutingError.new('Not Found') unless current_user.can?('edit_accounts')
  end

end
