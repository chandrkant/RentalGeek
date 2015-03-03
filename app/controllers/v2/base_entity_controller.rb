# REST API for Entities
#
# Note that there is no need to return a 404 Not Found from most actions,
# as Rails looks up the object before executing an action, and responds if not found.
class V2::BaseEntityController < ApplicationController
  include ControllerMixin
  ##
  # Returns a list of entities
  #
  # GET /<entities>
  def index
    page = params[:page]
    per_page = (params[:per_page] || 10).to_i
    if page
      entities = _all_instances_query.page(page).per(per_page)
      render json: entities, entity: _get_class,
      meta: { total_pages: entities.total_pages, total_count: entities.total_count }
    else
      entities = _all_instances_query
      respond_with entities, entity: '_get_class'
    end
  end

  ##
  # Returns 1 entity
  # GET /<entities>/1
  def show
    respond_with @entity, entity: _get_class
  end

  ##
  # Creates a new entity
  # POST /<entities>
  def create
    entity = _get_class.new(_entity_params)

    # do any object-specific processing, if any
    _process_on_create entity

    # Rails does not understand your route namespaces when inferring the route,
    # so it attempts <MODEL NAME>_url - a route which does not exist!
    # Adding symbols in front of the resource will allow Rails to infer the route correctly,
    # in the Company case,  api_v1_company_url

    # When using `respond_with`, you don't need to use `if record.save` before a `respond_with` call.
    # Rails will check if the record saved successfully for you and render a 422 with errors if it failed to save.
    # Cannot use save! here since save! does not suppress the exceptions
    status = entity.save
    _maybe_log_errors 'create', entity
    respond_with :v2, entity, entity: _get_class
  end

  ##
  # Updates a particular entity
  # PATCH will update parts of the entity where PUT updates entire entity
  # PATCH/PUT /<entities>/1
  def update
    if @entity.update(_entity_params)
      #respond_with @entity, entity: _get_class
      render :json => @entity
    else
      # TODO: no code coverage in tests - figure out a way to get this to execute
      _maybe_log_errors 'update', @entity
      respond_with(@entity, status: :unprocessable_entity, json: @entity.errors, entity: _get_class)
    end
  end

  ##
  # Soft deletes an entity
  # DELETE /<entities>/1
  def destroy
    if @entity.destroy
      render :text => '{}', :status => :ok
    else
      respond_with(@entity, status: :unprocessable_entity, json: @entity.errors, entity: _get_class)
    end
  end

  protected
  def _prepare_params
    # Do nothing
  end

  # To be overridden by sub-classes for any processing that's required on an entity
  # before it's saved to the DB in a 'create' action.
  def _process_on_create(entity)
  end

  private
  # Log details about invalid objects, unless we're in testing.
  def _maybe_log_errors verb, entity
    if !entity.valid? && !Rails.env.test?
      puts "ERROR: Cannot #{verb} #{_get_class} with params #{_entity_params}."
      entity.errors
    end
  end
end
