class RolesController < ApplicationController
  before_action :get_permissions

  def create
    @account = Account.find(params[:account_id])
    @role = Role.find(role_params[:id])

    unless @account.nil? and @role.nil?
      @account.roles << @role
      redirect_to @account, notice: 'Role was added.'
    else
      redirect_to @account, notice: 'Error adding role.'
    end
  end

  def destroy
    @account = Account.find(params[:account_id])
    @role = Role.find(params[:format])
    if @account.roles.delete(@role)
      redirect_to @account, notice: 'Role was deleted.'
    else
      redirect_to @account, notice: 'Error deleting role.'
    end
  end

  private

  def role_params
    params.require(:role).permit(:id)
  end

  def get_permissions
    raise ActionController::RoutingError.new('Not Found') unless current_user.can?('edit_roles')
  end
end
