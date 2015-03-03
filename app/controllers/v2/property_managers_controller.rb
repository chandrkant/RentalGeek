class V2::PropertyManagersController < V2::BaseEntityController

  private

  def _entity_params
    params.require(:property_manager).permit()
  end

  def _get_class
    PropertyManager
  end
end
