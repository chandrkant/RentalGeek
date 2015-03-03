class V2::ProfilesController < V2::BaseEntityController
  skip_before_filter :authenticate_applicant_from_token!, :only => :victig_callback
  skip_before_filter :authenticate_applicant!, :only => :victig_callback

  def victig_callback
  end
  private

  def _entity_params
    params.require(:profile).permit()
  end

  def _get_class
    Profile
  end
end
