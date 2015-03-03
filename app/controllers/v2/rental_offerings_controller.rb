require 'csv'
class V2::RentalOfferingsController < V2::BaseEntityController
  skip_before_filter :authenticate_applicant_from_token!, :only => [:index,:show]
  skip_before_filter :authenticate_applicant!, :only => [:index,:show]

  def index
   authenticate_with_http_token do |token, options|
      email = options[:email].presence
      applicant = email && Applicant.find_by_email(email)
      if applicant && Devise.secure_compare(applicant.authentication_token, token)
        sign_in applicant, store: false
      end
    end
    page = params[:page]
    per_page = (params[:per_page] || 10).to_i

    sql = "1=1 AND sold_out = false "
    sql = sql + "AND headline iLIKE '%#{params[:city]}%' " unless params[:city].blank?
    sql_order = "created_at DESC"
    unless params[:search].blank?
      sql = sql + "AND headline iLIKE '%#{params[:search][:location]}%' " unless params[:search][:location].blank?
      sql = sql + "AND monthly_rent_floor >= #{params[:search][:minPrice]} " unless params[:search][:minPrice].blank?
      sql = sql + "AND monthly_rent_floor <= #{params[:search][:maxPrice]} " unless params[:search][:maxPrice].blank?
      unless params[:search][:bedroom].blank?
        bedroom_sql = ""
        params[:search][:bedroom].split.each_with_index do |val,index|
          if index == 0
            if val == "4"
              bedroom_sql = bedroom_sql + "bedroom_count >=  #{val.to_i} "
            else
              bedroom_sql = bedroom_sql + "bedroom_count =  #{val.to_i} "
            end
          else
            if val == "4"
              bedroom_sql = bedroom_sql + "OR bedroom_count >=  #{val.to_i} "
            else
              bedroom_sql = bedroom_sql + "OR bedroom_count =  #{val.to_i} "
            end
          end
        end
       sql = sql + "AND (" +bedroom_sql+ ")"
      end
      sql_order = "monthly_rent_floor ASC " if params[:search][:sort] == 'pl'
      sql_order = "monthly_rent_floor DESC " if params[:search][:sort] == 'ph'
      sql_order = "created_at DESC " if params[:search][:sort] == 'r'
    end
    if page
      @rental_offerings = RentalOffering.includes({rental_complex: [:property_manager]}, :starred_properties).where(sql).order(sql_order).page(page).per(per_page)
      render json: @rental_offerings, meta: { total_pages: @rental_offerings.total_pages, total_count: @rental_offerings.total_count }
    else
      @rental_offerings = RentalOffering.includes({rental_complex: [:property_manager]}, :starred_properties).where(sql).order(sql_order)
      render json: @rental_offerings
    end
  end

  def applicants
    @rental_offering = RentalOffering.find(params[:rental_offering_id])
    @applies = @rental_offering.applies.where(accepted: [true, nil])
    render json: @applies, root: "applies"
  end

  def exportCsv
    @rental_offerings = RentalOffering.includes(:rental_complex => :property_manager)
    csv_file= CSV.generate({}) do |csv|
       csv << @rental_offerings.column_names
      @rental_offerings.each do |product|
        csv << product.attributes.values_at(* @rental_offerings.column_names)
      end
    end

    send_data csv_file,:type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "download; filename=rental.csv"
  end

  private

  def _entity_params
    params.require(:rental_offering).permit(:rental_complex_id, :earliest_available_on,:bedroom_count,:full_bathroom_count,:half_bathroom_count,
                                            :salesy_description,:rental_offering_type,:headline,:url,
                                            :monthly_rent_floor,:monthly_rent_ceiling,:square_footage_floor,
                                            :square_footage_ceiling,:sold_out,
                                            :buzzer_intercom,:central_air,:deck_patio,
                                            :dishwater,:doorman,:elevator,:fireplace,
                                            :gym,:hardwood_floor,:new_appliances,
                                            :parking_garage,:parking_outdoor,:pool,
                                            :storage_space,:vaulted_ceiling,:walkin_closet,
                                            :washer_dryer,:yard_private,:yard_shared,
                                            )
  end

  def _get_class
    RentalOffering
  end

end
