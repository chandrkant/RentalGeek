class ApplicantDecorator < Draper::Decorator

  delegate_all

  def desires_to_move_in_on
  	desires_to_move_in_on? ? desires_to_move_in_on.to_date.to_formatted_s(:long) : 'None given'
  end

  def was_ever_evicted
  	was_ever_evicted? ? "Yes" : "No"
  end

  def is_felon
  	is_felon? ? "Yes" : "No"
  end

  def pets_description
  	object.pets_description || "N/A"
  end

  def vehicles_description
  	object.vehicles_description || "N/A"
  end

  def middle_initial
  	upcase = object.middle_initial.upcase

  	if upcase[/\.\Z/]
  		upcase
  	else
  		"#{upcase}."
  	end
  end

  def full_name
    if middle_initial?
      "#{first_name} #{middle_initial} #{last_name}"
    else
      "#{first_name} #{last_name}"
    end
  end

  def roommates_description
  	roommates_description? ? object.roommates_description : "No response given"
  end

  def ssn
  	ssn? ? object.ssn : "No response given"
  end

  def phone_number
  	phone_number? ? object.phone_number : "No response given"
  end

  def drivers_license_number
  	drivers_license_number? ? object.drivers_license_number : "No response given"
  end

  def drivers_license_state
  	drivers_license_state? ? object.drivers_license_state : "No response given"
  end

  def bank_name
  	bank_name? ? object.bank_name : "No response given"
  end

  def bank_city_and_state
  	bank_city_and_state? ? object.bank_city_and_state : "No city and state given"
  end

  def emergency_contact_name
  	emergency_contact_name? ? object.emergency_contact_name : "No response given"
  end

  def emergency_contact_phone_number
  	emergency_contact_phone_number? ? object.emergency_contact_phone_number : "No phone number given"
  end

  def current_home_moved_in_on
    current_home_moved_in_on? ? object.current_home_moved_in_on.to_date.to_formatted_s(:long) : "No response given"
  end

  def employment_status
  	employment_status? ? object.employment_status.capitalize : "No response given"
  end

  def current_employment_started_on
    current_employment_started_on? ? object.current_employment_started_on.to_date.to_formatted_s(:long) : "No response given"
  end

  def previous_home_moved_in_on
    previous_home_moved_in_on? ? object.previous_home_moved_in_on.to_date.to_formatted_s(:long) : "No response given"
  end

  def previous_employment_started_on
    previous_employment_started_on? ? object.previous_employment_started_on.to_date.to_formatted_s(:long) : "[No response given]"
  end

  def previous_employment_ended_on
    previous_employment_ended_on? ? object.previous_employment_ended_on.to_date.to_formatted_s(:long) : "[No response given]"
  end
end
