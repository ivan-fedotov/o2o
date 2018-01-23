class DocumentsController < ApplicationController
    before_action :set_document, only: [:show, :edit, :update, :destroy]

    # GET /brigades
    # GET /brigades.json
    def index
      @documents = Document.all
      @i = params[:ticket].nil? ? Document.new : Document.new(ticket_params)
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
      @document = Document.new
    end

    # GET /brigades/1/edit
    def edit
    end

    # POST /brigades
    # POST /brigades.json
    def create
      @document = Document.new(document_params)

      respond_to do |format|
        if @document.save
          format.html { redirect_to site_path(@document.site, :anchor => get_doctype(@document)), notice: 'Document was successfully created.' }
          format.json { render :show, status: :created, location: @document }
        else
          format.html {
            p @document.errors
            redirect_to site_path(@document.site, :anchor => get_doctype(@document))
          }
          format.json { render json: @document.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /brigades/1
    # PATCH/PUT /brigades/1.json
    def update
      respond_to do |format|
        if @document.update(document_params)
          format.html { redirect_to @document, notice: 'Document was successfully updated.' }
          format.json { render :show, status: :ok, location: @document }
        else
          format.html { render :edit }
          format.json { render json: @document.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /brigades/1
    # DELETE /brigades/1.json
    def destroy
      @document.destroy
      respond_to do |format|
        format.html { redirect_to site_path(@document.site, :anchor => get_doctype(@document)), notice: 'Image was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :file, :site_id, :doctype)
    end

    def get_doctype(doc)
      ancors = ['schema_link', 'schema_power', 'access']
      ancors[doc.doctype]
    end
  end
