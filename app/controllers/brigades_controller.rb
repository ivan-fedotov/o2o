class BrigadesController < ApplicationController
  before_action :set_brigade, only: [:show, :edit, :update, :destroy]
  before_action :get_permissions, only: [:new, :create, :edit, :update, :destroy]
  before_action :get_permissions_on_show, only: [:show]
  # GET /brigades
  # GET /brigades.json
  def index
    @b = params[:brigade].nil? ? Brigade.new : Brigade.new(brigade_params)
    @brigades = Brigade.all
    @brigades = @brigades.search(params[:brigade][:search_filter]) if params[:brigade].present? and params[:brigade][:search_filter].present?
    @statuses = Status.all
  end

  # GET /brigades/1
  # GET /brigades/1.json
  def show
  end

  # GET /brigades/new
  def new
    @brigade = Brigade.new
  end

  # GET /brigades/1/edit
  def edit
  end

  # POST /brigades
  # POST /brigades.json
  def create
    @brigade = Brigade.new(brigade_params)

    respond_to do |format|
      if @brigade.save
        format.html { redirect_to @brigade, notice: 'Brigade was successfully created.' }
        format.json { render :show, status: :created, location: @brigade }
      else
        format.html { render :new }
        format.json { render json: @brigade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brigades/1
  # PATCH/PUT /brigades/1.json
  def update
    respond_to do |format|
      if @brigade.update(brigade_params)
        format.html { redirect_to @brigade, notice: 'Brigade was successfully updated.' }
        format.json { render :show, status: :ok, location: @brigade }
      else
        format.html { render :edit }
        format.json { render json: @brigade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brigades/1
  # DELETE /brigades/1.json
  def destroy
    @brigade.destroy
    respond_to do |format|
      format.html { redirect_to brigades_url, notice: 'Brigade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brigade
      @brigade = Brigade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brigade_params
      params.require(:brigade).permit(:title, :description, :search_filter)
    end

    def get_permissions
      raise ActionController::RoutingError.new('Not Found') unless current_user.can?('edit_brigades')
    end

    def get_permissions_on_show
      raise ActionController::RoutingError.new('Not Found') unless current_user.can?('see_brigade')
    end
end
