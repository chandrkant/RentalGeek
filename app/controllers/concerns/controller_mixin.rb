# Mixin for combining the auth and basic configuration set up.
# Also adds the load_and_authorize_resource call after the other mixins are called prior so it works properly
module ControllerMixin
  extend ActiveSupport::Concern
  include AuthControllerMixin
  include BeforeControllerMixin
  include BasicControllerMixin

  included do
    load_and_authorize_resource
  end

end
