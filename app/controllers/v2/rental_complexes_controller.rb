class V2::RentalComplexesController < V2::BaseEntityController

  def index
    page = params[:page]
    per_page = (params[:per_page] || 10).to_i
    if page
      @rental_complexes = RentalComplex.page(page).per(per_page)
      render json: @rental_complexes,meta: { total_pages: @rental_complexes.total_pages, total_count: @rental_complexes.total_count }
    else
      @rental_complexes = RentalComplex
      render json: @rental_complexes
    end
  end

 def create_property
    if !params[:rental_complex].blank?
      rental_complex=RentalComplex.new(_entity_params)
      rental_complex.save!
      rental_offering= rental_complex.rental_offerings.new(
                          headline:params[:rental_complex][:full_address] ,
                          bedroom_count:params[:rental_offerings][:bedroom_count],
                          full_bathroom_count: params[:rental_offerings][:full_bathroom_count],
                          half_bathroom_count:params[:rental_offerings][:full_bathroom_count],
                          earliest_available_on:Date.today+15,
                          monthly_rent_floor:params[:rental_offerings][:price],
                          monthly_rent_ceiling:params[:rental_offerings][:price],
                          rental_offering_type:nil
                        )

      if rental_complex.save! && rental_offering.save!
        if params[:property_photos] && params[:property_photos][:photo]
          params[:property_photos][:photo].each { |photo|
            rental_offering.property_photos.create(:photo=>photo)
          }
        end
        render json:{rental_offering:rental_offering} ,status:200
      else
        msg= rental_complex.errors.messages.first[0].to_s    unless rental_complex.save
        msg= rental_offering.errors.messages.first[0].to_s    unless rental_offering.save
        render json: msg ,status:404
      end
    end
  end

  private

  def _entity_params
     params.require(:rental_complex).permit(:property_manager_id, :name,:url,:full_address,
                                          :salesy_description,:customer_contact_email_address,:headline,:customer_contact_phone_number,
                                          rental_offerings_attributes: [:price, :full_bathroom_count,:bedroom_count],
                                          property_photos:[:photo]
                                          )
  end

  def _get_class
    RentalComplex
  end
end
