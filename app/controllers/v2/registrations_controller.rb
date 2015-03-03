class V2::RegistrationsController < Devise::RegistrationsController
  def create
    
      build_resource(applicant_params)

      resource_saved = resource.save
      yield resource if block_given?
      if resource_saved
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          render json: resource
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          render json: {error: resource.errors.full_messages}
        end
      else
        clean_up_passwords resource
        @validatable = devise_mapping.validatable?
        if @validatable
          @minimum_password_length = resource_class.password_length.min
        end
        render json: {error: resource.errors.full_messages}
      end
    end

  private
    def applicant_params
      params.require(:applicant).permit(:email, :password, :password_confirmation)
    end
end
