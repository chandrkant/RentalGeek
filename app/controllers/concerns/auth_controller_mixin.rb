# Mixin for configuring the authorization
module AuthControllerMixin
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_applicant_from_token!
    # This is Devise's authentication
    before_action :authenticate_applicant!, except: [:exportCsv]
  end

  def current_ability
    @current_ability ||= Ability.new(current_applicant)
  end

  # Get the auth token
  def authenticate_applicant_from_token!
    if params[:action]=="exportCsv"
      email =   Base64.decode64(params[:user_email]).presence
      applicant = email && Applicant.find_by_email(email)
      token     =  Base64.decode64(params[:user_token])
      if applicant && Devise.secure_compare(applicant.authentication_token, token)
          sign_in applicant, store: false
        end
    else
      authenticate_with_http_token do |token, options|
        email = options[:email].presence
        applicant = email && Applicant.find_by_email(email)
        if applicant && Devise.secure_compare(applicant.authentication_token, token)
          sign_in applicant, store: false
        end
      end
    end
  end
end
