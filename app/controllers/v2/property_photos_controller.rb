class V2::PropertyPhotosController < V2::BaseEntityController
  skip_before_filter :authenticate_applicant_from_token!, :only => :index
  skip_before_filter :authenticate_applicant!, :only => :index

  def index
    if params[:rental_offering_id]
      @rental_offering = RentalOffering.find(params[:rental_offering_id])
      @property_photos = @rental_offering.property_photos
    else
      @rental_offering = RentalOffering.all
    end
    render json: @property_photos
  end

  def update_property_photo
   @property_photo=PropertyPhoto.find_by_id(params[:property_photo][:id])
   update =@property_photo.update_attributes(:photo=>params[:property_photo][:photo])

   render json: update
 end

 def delete_property_photo
  @property_photo=PropertyPhoto.find_by_id(params[:id])
  rental_offering=RentalOffering.find_by_id(@property_photo.rental_offering_id)
  delete= @property_photo.destroy
  render json: rental_offering.property_photos
 end

 def uplode_property_photo
  rental_offering=RentalOffering.find(params[:rental_offering_id])
  if params[:property_photo][:photo]
    params[:property_photo][:photo].each { |photo|
     property_photo= rental_offering.property_photos.create(:photo=>photo)
     property_photo.update(photo_thumb_url:property_photo.photo.url(:thumb))
     property_photo.update(photo_full_url: property_photo.photo.url(:full))
    }
  end
   render json:rental_offering.property_photos
  end
  private

  def _entity_params
    params.require(:property_photo).permit!
  end

  def _get_class
    PropertyPhoto
  end
end
