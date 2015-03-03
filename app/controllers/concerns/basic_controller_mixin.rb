# Mixin for setting up the Controller
module BasicControllerMixin
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :_record_not_found
    respond_to :json
  end

  def _record_not_found
    respond_with(params, status: :not_found, json: params)
  end
end
