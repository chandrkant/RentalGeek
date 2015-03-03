class V2::Landlord::RentalComplexesController < V2::BaseEntityController
  
  private

  def _entity_params
     params.require(:rental_complex).permit(:property_manager_id, :name,:bedroom_count,:url,:full_address,
                                          :salesy_description,:customer_contact_email_address,:headline,:customer_contact_phone_number
                                          )
  end

  def _get_class
    RentalComplex
  end
end
