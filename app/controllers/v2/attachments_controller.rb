class V2::AttachmentsController < V2::BaseEntityController

  private
  def _entity_params
    params[:attachment][:property_manager_id] = current_applicant.property_manager.id
    params.require(:attachment).permit(:attachment, :property_manager_id)
  end

  def _get_class
    Attachment
  end
end
