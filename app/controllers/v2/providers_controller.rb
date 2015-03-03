class V2::ProvidersController < V2::BaseEntityController

  def update
    @applicant = current_applicant
  	@provider = @applicant.providers.find(params[:id])
  	if @provider.update(connected:false)
	   render json: @current_applicant, root: "applicant"
  	else
  	 render json: @provider.errors, status: :unprocessable_entity
  	end
  end

  private

  def _entity_params
    params.require(:provider).permit()
  end

  def _get_class
    Provider
  end
end
