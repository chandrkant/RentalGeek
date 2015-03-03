class V2::CoSignersController < V2::BaseEntityController

  def invite_cosigner
  	@request = request.env['HTTP_ORIGIN'];

    @apply_id = params[:co_signer][:apply].split(" ")
    @apply_id.each do|apply|
      @apply = Apply.find(apply)
      @property = @apply.rental_offering
      ApplicantMailer.delay.cosigner_invite(params[:co_signer][:invitee], current_applicant, @property, apply, @request)
    end
    render json: {:success=>true}
  end

  private

  def _entity_params
    params[:co_signer][:co_sign_attributes] = [params[:co_signer][:co_sign_attributes]] if params[:co_signer] && params[:co_signer][:co_sign_attributes]
    params[:co_signer][:applicant_id] = current_applicant.id
    params.require(:co_signer).permit(:first_name, :last_name, :ssn, :dob, :address,:applicant_id,
                                      :city, :state, :zip_code, :phone, :email, :rent_own,
                                      :landlord_phone, :rent_mortage,:spouse_employer_name,
                                      :employer_name, :emp_position, :m_gross_income, :a_source_income,
                                      :marrital_status, :spouse_name, :spouse_ssn, :spouse_dob,
                                      :spouse_position, :spouse_monthly_gross_income, :checking_account_bank_name,
                                      :spouse_additional_source_income, :saving_account_bank_name,
                                      :lenders_name, :loan_type, :o_court_judgement, :party_lawsuit,
                                      :property_foreclosed, :declared_bankruptcy, :is_felony,
                                      :invitee,:apply,
                                      co_sign_attributes:[
                                        :id, :cosigning_for, :apply_id, :relationship,:signature_date
                                      ],

                                      )
  end

  def _get_class
    CoSigner
  end
end
