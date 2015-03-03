class RentalOfferingDecorator < Draper::Decorator

  delegate_all	

  def earliest_available_on
  	object.earliest_available_on? ? object.earliest_available_on.to_date.to_s(:long) : "None given"
  end

  def rental_offering_type
  	object.rental_offering_type? ? object.rental_offering_type : "Unknown"
  end

  def bathroom_count
  	half_bathroom_count? ? "#{full_bathroom_count}.5" : full_bathroom_count
  end

  def square_footage_copy
  	square_footage.present? ? "#{square_footage} sq. ft." : "sq. ft. not given"
  end

  def monthly_rent_copy
  	"#{monthly_rent}/mo."
  end
  
  def bedroom_count_compact
    object.bedroom_count > 0 ? "#{object.bedroom_count}br" : "studio"
  end

 private

  include ActionView::Helpers::NumberHelper

  def monthly_rent

  	if monthly_rent_floor == monthly_rent_ceiling
  		return "$#{number_with_delimiter(monthly_rent_ceiling)}"
  	else
  		return "$#{number_with_delimiter(monthly_rent_floor)} - $#{number_with_delimiter(monthly_rent_ceiling)}"
  	end
  end

  def square_footage

  	return nil unless square_footage_ceiling && square_footage_floor

  	if square_footage_floor == square_footage_ceiling
  		return number_with_delimiter(square_footage_ceiling).to_s
  	else
  		return "#{number_with_delimiter(square_footage_floor)} - #{number_with_delimiter(square_footage_ceiling)}"
  	end
  end
end
