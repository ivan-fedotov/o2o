class PhotoReportsController < ApplicationController
  #Create action ensures that submitted photo gets created if it meets the requirements
  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to ticket_path(@photo.photo_collection.ticket)
    else
      p @photo.errors
      render :new
    end
  end

  private

  #Permitted parameters when creating a photo. This is used for security reasons.
  def photo_params
    params.require(:photo).permit(:title, :image, :site_id, :photo_collection_id)
  end
end
