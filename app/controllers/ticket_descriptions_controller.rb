class TicketDescriptionsController < ApplicationController
  before_action :set_ticket_description, only: [:show, :edit, :update, :destroy]

  # GET /ticket_descriptions
  # GET /ticket_descriptions.json
  def index
    @ticket_descriptions = TicketDescription.all
  end

  # GET /ticket_descriptions/1
  # GET /ticket_descriptions/1.json
  def show
  end

  # GET /ticket_descriptions/new
  def new
    @ticket_description = TicketDescription.new
  end

  # GET /ticket_descriptions/1/edit
  def edit
  end

  # POST /ticket_descriptions
  # POST /ticket_descriptions.json
  def create
    @ticket_description = TicketDescription.new(ticket_description_params)

    respond_to do |format|
      if @ticket_description.save
        format.html { redirect_to @ticket_description, notice: 'Ticket description was successfully created.' }
        format.json { render :show, status: :created, location: @ticket_description }
      else
        format.html { render :new }
        format.json { render json: @ticket_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_descriptions/1
  # PATCH/PUT /ticket_descriptions/1.json
  def update
    respond_to do |format|
      if @ticket_description.update(ticket_description_params)
        format.html { redirect_to @ticket_description, notice: 'Ticket description was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket_description }
      else
        format.html { render :edit }
        format.json { render json: @ticket_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_descriptions/1
  # DELETE /ticket_descriptions/1.json
  def destroy
    @ticket_description.destroy
    respond_to do |format|
      format.html { redirect_to ticket_descriptions_url, notice: 'Ticket description was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_description
      @ticket_description = TicketDescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_description_params
      params.require(:ticket_description).permit(:title)
    end
end
