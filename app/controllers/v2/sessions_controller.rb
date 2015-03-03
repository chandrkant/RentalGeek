class V2::SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    resource = Applicant.find_for_database_authentication(:email=>params[:applicant][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:applicant][:password])
      sign_in("applicant", resource)
      render json: resource
      return
    end
    invalid_login_attempt
  end

  def add_providers
    if !params[:provider].blank?
      @provider=Provider.find_by_uid(params[:provider][:uid])
      applicant=Applicant.find_by_email(params[:provider][:email])
      if params[:link_account]
        applicant=Applicant.find(params[:applicant_id])
        @prov = applicant.providers.where(uid: params[:provider][:uid], provider: params[:provider][:provider])
        if @prov.blank?
          @prov = applicant.providers.create(uid: params[:provider][:uid], provider: params[:provider][:provider], name: params[:provider][:name], email: params[:provider][:email])
          render json: applicant
        else
          @prov.first.update(provider:params[:provider][:provider],connected:true)
          render json: applicant 
        end
      else
        if @provider.nil?
            @provider=Provider.new(uid: params[:provider][:uid], provider: params[:provider][:provider], name: params[:provider][:name], email: params[:provider][:email])
            if !applicant.nil?
             @provider.applicant_id=applicant.id
             @provider.save
            end
        else
          @provider.update(provider:params[:provider][:provider],connected:true)
        end
        if applicant.nil?

          applicant=Applicant.new(email:params[:provider][:email],first_name:params[:provider][:first_name],password:'12345678',password_confirmation:'12345678',facebook_image:params[:provider][:facebook_image],google_image:params[:provider][:google_image])

           applicant.save
           @provider.applicant_id=applicant.id
           @provider.save
           sign_in(resource_name,applicant)
           render json: applicant 
        else
           applicant.update(facebook_image:params[:provider][:facebook_image],google_image:params[:provider][:google_image])
           sign_in(resource_name,applicant)
           render json: applicant
        end
      end
    end
  end

  def destroy
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
      yield if block_given?
     render json:  {sign_out: true}, success:  true, status:  200
  end

protected
  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end
