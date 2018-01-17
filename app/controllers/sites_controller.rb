class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
    @s = params[:site].nil? ? Site.new : Site.new(site_params)
    @brigades = Brigade.all
    @sites = Site.all
    @sites = @sites.brigade(params[:site][:brigade_filter]) if params[:site].present? and params[:site][:brigade_filter].present?
    @sites = @sites.search(params[:site][:search_filter]) if params[:site].present? and params[:site][:search_filter].present?
    @sites = @sites.paginate(:page => params[:page], :per_page => 30)
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @brigades = Brigade.all
    @photo = @site.photos.new
    @document = @site.documents.new
    @photos = @site.photos.site_photos.existing
    @documents_sl = @site.documents.sl.existing
    @documents_sp = @site.documents.sr.existing
    @documents_ac = @site.documents.ac.existing
  end

  # GET /sites/new
  def new
    @site = Site.new
    @brigades = Brigade.all
    @brigades = Brigade.all
    @photo = @site.photos.new
    @document = @site.documents.new
    @photos = @site.photos.existing
    @photos_no_pc = @photos
    @documents_sl = @site.documents.sl.existing
    @documents_sp = @site.documents.sr.existing
    @documents_ac = @site.documents.ac.existing
  end

  # GET /sites/1/edit
  def edit
    @brigades = Brigade.all
    @photo = @site.photos.new
    @document = @site.documents.new
    @photos = @site.photos.site_photos.existing
    @photos_no_pc = @photos
    @documents_sl = @site.documents.sl.existing
    @documents_sp = @site.documents.sr.existing
    @documents_ac = @site.documents.ac.existing
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_site
    @site = Site.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def site_params
    params.require(:site).permit(:network_name, :adress_info, :distance, :access_info, :keys_info, :power_info, :etc, :brigade_id, :brigade_filter, :search_filter)
  end
end
