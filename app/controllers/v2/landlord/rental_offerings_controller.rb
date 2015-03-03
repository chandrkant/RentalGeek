class V2::Landlord::RentalOfferingsController < V2::BaseEntityController

  def index
    page = params[:page]
    per_page = (params[:per_page] || 10).to_i
    if page
      entities = _all_instances_query.order('applies_count DESC').page(page).per(per_page)
      render json: entities, entity: _get_class,
      meta: { total_pages: entities.total_pages, total_count: entities.total_count }
    else
      entities = _all_instances_query
      respond_with entities, entity: '_get_class'
    end
  end

  def upload_csv_file
    spreadsheet= params[:file]
    RentalOffering.transaction do
      spreadsheet= open_spreadsheet(spreadsheet)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        address=row.to_hash['STREET'].to_s+","+row.to_hash['UNIT'].to_s+","+row.to_hash['CITY'].to_s+","+row.to_hash['STATE'].to_s+","+row.to_hash['ZIP CODE'].to_s
        rental_complex=RentalComplex.new(
         property_manager:current_applicant.property_manager,
         full_address: address,
         street_name:row.to_hash['STREET'],
         cross_street_name:row.to_hash['CITY']
         )
        rental_complex.save

        rental_offering= RentalOffering.new(
          headline:address ,
          bedroom_count:row.to_hash['BEDROOMS'],
          rental_complex_id:rental_complex.id,
          full_bathroom_count: row.to_hash['BATHROOMS'],
          half_bathroom_count:row.to_hash['BATHROOMS'],
          earliest_available_on:row[12],
          monthly_rent_floor:row.to_hash['RENT'],
          monthly_rent_ceiling:row.to_hash['RENT'],
          url:row.to_hash['PHOTOS'])
          rental_offering.save
        end
      render json:{msg:true} ,status:200
      end
    end

    def   open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path,{})
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
      end
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
                                            :washer_dryer,:yard_private,:yard_shared
                                            )
  end

  def _get_class
    RentalOffering
  end
end
