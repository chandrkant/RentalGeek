class V2::CoSignsController < V2::BaseEntityController

  private

  def _entity_params
    params.require(:co_sign).permit!
  end

  def _get_class
    CoSign
  end
end
