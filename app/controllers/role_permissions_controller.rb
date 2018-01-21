class RolePermissionsController < ApplicationController
  before_action :set_role_permission, only: [:show, :edit, :update, :destroy]
  before_action :get_permissions

  # GET /role_permissions
  # GET /role_permissions.json
  def index
    @role_permissions = RolePermission.all
  end

  # GET /role_permissions/1
  # GET /role_permissions/1.json
  def show
  end

  # GET /role_permissions/new
  def new
    @role_permission = RolePermission.new
    @statuses = Status.all
    @roles = Role.all
  end

  # GET /role_permissions/1/edit
  def edit
    @statuses = Status.all
    @roles = Role.all
    @permissions = Permission.new( @role_permission.permissions )
  end

  # POST /role_permissions
  # POST /role_permissions.json
  def create
    @role_permission = RolePermission.new(role_permission_params)
    @statuses = Status.all
    @roles = Role.all
    @permission = Permission.new(role_permission_prms)
    @role_permission.permissions = @permission.to_string

    begin
      respond_to do |format|
        if @role_permission.save
          format.html { redirect_to @role_permission, notice: 'Role permission was successfully created.' }
          format.json { render :show, status: :created, location: @role_permission }
        else
          format.html { render :new }
          format.json { render json: @role_permission.errors, status: :unprocessable_entity }
        end
      end
    rescue => error
      puts error.inspect
      redirect_to role_permissions_path
    end
  end

  # PATCH/PUT /role_permissions/1
  # PATCH/PUT /role_permissions/1.json
  def update
    @permission = Permission.new( params[:prms] )
    p role_permission_params
    #if @permission.size == 0
    #  rp_params = role_permission_params
    #else
      rp_params = role_permission_params.to_h.merge!( permissions: @permission.to_string )
    #end
    respond_to do |format|
      if @role_permission.update( rp_params )
        format.html { redirect_to role_permissions_path, notice: 'Role permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @role_permission }
      else
        format.html { render :edit }
        format.json { render json: @role_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_permissions/1
  # DELETE /role_permissions/1.json
  def destroy
    @role_permission.destroy
    respond_to do |format|
      format.html { redirect_to role_permissions_url, notice: 'Role permission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_role_permission
    @role_permission = RolePermission.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_permission_params
    params.require(:role_permission).permit(:role_id, :status_id, :permissions, :statuses)
  end

  def role_permission_prms
    prms = params.fetch(:prms, {}).permit!
  end

  def get_permissions
    raise ActionController::RoutingError.new('Not Found') unless current_user.can?('edit_permissions')
  end
end
