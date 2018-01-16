class PhotosController < ApplicationController

  #Create action ensures that submitted photo gets created if it meets the requirements
  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      if @photo.photo_collection.nil?
        redirect_to site_path(@photo.site, :anchor => "fotos")
      else
        redirect_to ticket_path(@photo.photo_collection.ticket)
      end
    else
      p @photo.errors
      render :new
    end
  end

  private

  #Permitted parameters when creating a photo. This is used for security reasons.
  def photo_params
    params.require(:photo).permit(:title, :image, :site_id, :message_id)
  end

end
