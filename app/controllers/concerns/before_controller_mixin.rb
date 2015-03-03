# Mixin for setting up the Controller
module BeforeControllerMixin
  extend ActiveSupport::Concern

  included do
    before_action :_set_entity, only: [:show, :update, :destroy]
    before_action do
      resource = controller_name.singularize.to_sym
      method = '_entity_params'
      params[resource] &&= send(method) if respond_to?(method, true)
    end
  end

  def _all_instances_query
    klazz = _get_class
    if params[:count]
      klazz.accessible_by(current_ability).order('id desc').limit(params[:count])
    else
      klazz.accessible_by(current_ability)
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def _set_entity
    @entity = _all_instances_query.find(params[:id])
  end

end
