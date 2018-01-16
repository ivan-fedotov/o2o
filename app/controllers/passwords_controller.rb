class PasswordsController < ApplicationController
  def new
    @password = Account.find(params[:account_id]).password
  end

  def update
    @password = Account.find(params[:account_id]).password
    if @password.set_password( safe_params[:secret] )
      redirect_to accounts_path
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
end
