class TicketsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :create_message]
  before_action :get_permissions

  # GET /tickets
  # GET /tickets.json
  def index
    @brigades = Brigade.all
    @authors = Account.where(is_service: false)
    @ticket_types = TicketType.all
    @sites = Site.all
    @statuses = Status.all
    @ticket_descriptions = TicketDescription.all
    @t = params[:ticket].nil? ? Ticket.new : Ticket.new(ticket_params)
    @tickets = Ticket.all
    if params[:ticket].present? and params[:ticket][:status_filter].present?
      @tickets = @tickets.status(params[:ticket][:status_filter])
    else
      @tickets = @tickets.joins(:status).where('statuses.is_hidden IS NULL')
    end
    @tickets = @tickets.site(params[:ticket][:site_filter]) if params[:ticket].present? and params[:ticket][:site_filter].present?
    @tickets = @tickets.brigade(params[:ticket][:brigade_filter]) if params[:ticket].present? and params[:ticket][:brigade_filter].present?
    @tickets = @tickets.author(params[:ticket][:author_filter]) if params[:ticket].present? and params[:ticket][:author_filter].present?
    @tickets = @tickets.ticket_type(params[:ticket][:ticket_type_filter]) if params[:ticket].present? and params[:ticket][:ticket_type_filter].present?
    @tickets = @tickets.search(params[:ticket][:search_filter]) if params[:ticket].present? and params[:ticket][:search_filter].present?
    @tickets = @tickets.order("tickets." + sort_column + " " + sort_direction)

    respond_to do |format|
      format.html { @tickets = @tickets.paginate(:page => params[:page], :per_page => 15) }
      format.xls #{ send_data @tickets.to_csv(col_sep: "\t") }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @sites = Site.all
    @role_statuses = current_user.statuses(@ticket.status_id)
    p @role_statuses
    @statuses = (@role_statuses == []) ? Status.all : Status.find(@role_statuses)
    @authors = Account.where(is_client: true)
    @brigades = Brigade.all
    @ticket_types = TicketType.all
    @ticket_descriptions = TicketDescription.all
    @msg = @ticket.messages.new
    @photo = @ticket.photo_collection.photos.new
    @photos = @ticket.photo_collection.photos.existing
    @result = 0
    @ticket.counts.each do |c|
      @result += (c.price_on_init || 0) * (c.quantity || 0)
    end
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @sites = Site.all
    @ticket.author_id = current_user.id if current_user.is_client
    @authors = Account.where(is_client: true)
    @brigades = Brigade.all
    @ticket_types = TicketType.all
    @ticket_descriptions = TicketDescription.all
  end

  # GET /tickets/1/edit
  def edit
    @authors = Account.where(is_client: true)
    @brigades = Brigade.all
    @sites = Site.all
    @ticket_types = TicketType.all
    @ticket_descriptions = TicketDescription.all
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket_types = TicketType.all
    @sites = Site.all
    @authors = Account.where(is_client: true)
    @brigades = Brigade.all
    @ticket.status_id = Status.where(is_first: true).first.id
    @ticket.status_id = 1 if @ticket.status_id.nil?
    @ticket.brigade_id = @ticket.site.brigade_id unless @ticket.site.nil?
    @ticket_descriptions = TicketDescription.all

    respond_to do |format|
      if @ticket.save
        if @ticket.deadline.nil?
          if @ticket.ticket_type_id > 1
            @ticket.deadline = Time.now + 7.days
          else
            @ticket.deadline = Time.now + 4.hours
          end
        end
        msg = "Заявка создана."
        unless @ticket.content.nil?
          msg = msg + " Доп. информация: =#{ @ticket.content }="
        end
        @message = Message.new(content: msg, author_id: current_user.id, ticket_id: @ticket.id)
        @message.save
        @ticket.save
        format.html { redirect_to root_path, notice: "Заявка #{ @ticket.number } создана." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    @sites = Site.all
    @statuses = Status.all
    @authors = Account.where(is_service: false)
    @brigades = Brigade.all
    @ticket_types = TicketType.all
    @ticket_descriptions = TicketDescription.all
    @result = 0
    @ticket.counts.each do |c|
      @result += (c.price_on_init || 0) * (c.quantity || 0)
    end
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :show }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_message
    @message = Message.new(message_params)
    @ticket_types = TicketType.all
    @ticket_descriptions = TicketDescription.all
    @sites = Site.all
    @authors = Account.where(is_service: false)
    @brigades = Brigade.all
    @message.author_id = current_user.id
    respond_to do |format|
      if @message.save
        if params[:images]
          #===== The magic is here ;)
          params[:images].each { |image|
            @message.photos.create(image: image, site_id: @message.ticket.site.id)
          }
        end
        format.html { redirect_to @message.ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:number])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ticket_params
    params.require(:ticket).permit(:number, :sort, :direction,:ticket_description_id, :deadline, :reported,  :site_id, :author_id, :ticket_type_id, :brigade_id, :title, :time_new, :time_at_site, :time_done, :status_id, :site_filter, :status_filter, :brigade_filter, :author_filter, :ticket_type_filter, :search_filter, :content, :chrono, counts_attributes: [:id, :title, :ticket_id, :price_id, :price_on_init, :quantity, :is_opex, :extra, :_destroy])
  end

  def message_params
    params.require(:message).permit(:author_id, :content, :ticket_id, :photos_attributes => [:image, :site_id])
  end

  def sort_column
    Ticket.column_names.include?(params[:sort]) ? params[:sort] : "deadline"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def get_permissions
    raise ActionController::RoutingError.new('Not Found') if ["edit", "destroy"].include?(params[:action])
    raise ActionController::RoutingError.new('Not Found') if ["show"].include?(params[:action]) and !current_user.can?('see_ticket')
    raise ActionController::RoutingError.new('Not Found') if ["update"].include?(params[:action]) and !current_user.can?('edit_ticket')
    raise ActionController::RoutingError.new('Not Found') if ["create_message"].include?(params[:action]) and !current_user.can?('send_ticket_message')
    raise ActionController::RoutingError.new('Not Found') if (!current_user.can?('open_ticket') and ["new", "create"].include?(params[:action]))
  end
end
