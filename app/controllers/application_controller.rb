require 'csv'
require 'iconv'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  respond_to :html, :json

  # before_action do
  #   resource = controller_name.singularize.to_sym
  #   method = '_entity_params'
  #   params[resource] &&= send(method) if respond_to?(method, true)
  # end

  helper_method :is_property_manager?
  rescue_from CanCan::AccessDenied do |exception|
    render status: :forbidden, json: {message: 'forbidden'}
  end

  serialization_scope :view_context


def update_rental
  @rental_offering=RentalOffering.find(params[:id])

  @rental_offering.rental_complex.update_attributes(
   full_address: params[:unit][:address]
   )
  @rental_offering.update_attributes(

    headline:params[:unit][:address] ,
    bedroom_count:params[:unit][:beds],

    full_bathroom_count: params[:unit][:bath],
    half_bathroom_count:params[:unit][:bath],
    earliest_available_on:Date.today+15,
    monthly_rent_floor:params[:unit][:price]
    )

  render json:{rental_offering: @rental_offering} ,status:200
end


private
def photo_params
  params.require(:property_photo).permit(:id,:photo)
end
protected
helper_method :current_applicant

end

