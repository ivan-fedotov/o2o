class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /brigades
  # GET /brigades.json
  def index
    @images = Photo.all
    @i = params[:ticket].nil? ? Photo.new : Photo.new(ticket_params)
    @authors = Account.where(is_service: false)
    @sites = Site.all
    @statuses = Status.all
  end

  # GET /brigades/1
  # GET /brigades/1.json
  def show
  end

  # GET /brigades/new
  def new
    @image = Photo.new
  end

  # GET /brigades/1/edit
  def edit
  end

  # POST /brigades
  # POST /brigades.json
  def create
    @image = Photo.new(image_params)
    if params[:ticket_number].present?
      @ticket = Ticket.find(params[:ticket_id])
      if @ticket.photo_collection.nil?
        pc = @ticket.photo_collection.new
        pc.save
        @image.photo_collection = pc
      end
    end
    respond_to do |format|
      if @image.save

        format.html do
          if @image.photo_collection.nil?
            redirect_to site_path(@image.site, :anchor => 'photos'), notice: 'Image was successfully created.'
          else
            redirect_to ticket_path(@image.photo_collection.ticket), notice: 'Image was successfully created.'
          end
        end
        format.json { render :show, status: :created, location: @image }
      else
        format.html { redirect_to site_path(@image.site, :anchor => 'photos') }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brigades/1
  # PATCH/PUT /brigades/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brigades/1
  # DELETE /brigades/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to site_path(@image.site, :anchor => 'photos'), notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Photo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:photo).permit(:title, :image, :site_id, :photo_collection_id, :ticket_id)
  end
end
