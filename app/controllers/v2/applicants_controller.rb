class V2::ApplicantsController < V2::BaseEntityController

  def update_password
    @applicant = Applicant.find(params[:id])
    if @applicant.update(applicant_pass_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @applicant, :bypass => true
      render json: @applicant
    else
      render json: @applicant.errors, status: :unprocessable_entity
    end
  end
 
  private

  # Only allow a trusted parameter "white list" through.
  def _entity_params

    params[:applicant][:profile_attributes][:id] =  params[:applicant][:profile_id] if params[:applicant][:profile_id]
    params[:applicant][:property_manager_attributes][:id] =  params[:applicant][:property_manager_id] if params[:applicant][:property_manager_id]
    params.require(:applicant).permit(:first_name, :last_name, :email, :avatar,
                                      profile_attributes: [
                                      :id, :born_on, :ssn,:drivers_license_number,:drivers_license_state,
                                      :phone_number,:bank_name,:bank_city_and_state,:pets_description,
                                      :vehicles_description,:was_ever_evicted,:was_ever_evicted_explanation,
                                      :is_felon,:is_felon_explanation,:character_reference_name,
                                      :character_reference_contact_info,:emergency_contact_name,
                                      :emergency_contact_phone_number,:current_home_street_address,
                                      :current_home_moved_in_on,:current_home_dissatisfaction_explanation,
                                      :current_home_owner,:current_home_owner_contact_info,
                                      :previous_home_street_address,:previous_home_moved_in_on,
                                      :previous_home_dissatisfaction_explanation,:previous_home_owner,
                                      :previous_home_owner_contact_info,:employment_status,
                                      :current_employment_position,:current_employment_monthly_income,
                                      :current_employment_supervisor,:current_employment_employer,
                                      :current_employment_employer_phone_number,
                                      :current_employment_employer_email_address,:current_employment_started_on,
                                      :previous_employment_position,
                                      :previous_employment_monthly_income,:previous_employment_supervisor,
                                      :previous_employment_employer,:previous_employment_employer_phone_number,
                                      :previous_employment_employer_email_address,:previous_employment_started_on,
                                      :previous_employment_ended_on,:other_income_monthly_amount,
                                      :other_income_sources,:cosigner_name,:cosigner_email_address,
                                      :desires_to_move_in_on,:roommates_description,:previous_home_moved_out
                                       ],
                                      property_manager_attributes:[
                                        :id, :name, :customer_contact_email_address, :customer_contact_phone_number,
                                        :accepts_cash, :accepts_checks, :accepts_credit_cards_offline, :accepts_online_payments,
                                        :accepts_money_orders, :url, :name
                                      ],
                                      )
  end

  def _get_class
    Applicant
  end

  def applicant_pass_params
  	params.require(:applicant).permit(:password, :password_confirmation)
  end
end
