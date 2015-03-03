class V2::StarredPropertiesController < V2::BaseEntityController

	def index
	    @starred_properties = current_applicant.starred_properties.includes(:rental_offering)
	    render json: @starred_properties
  	end

	def remove_star
		@starred_properties = current_applicant.starred_properties.find_by_rental_offering_id(params[:rental_offering_id])
		@starred_properties.destroy
		render json: @starred_properties, root: "starred_properties"
	end

	private

	def _entity_params
	params.require(:starred_property).permit(:applicant_id, :rental_offering_id)
	end

	def _get_class
	StarredProperty
	end
end
