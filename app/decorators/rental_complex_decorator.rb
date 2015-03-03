class RentalComplexDecorator < Draper::Decorator

  delegate_all

  def name
  	name? ? object.name : 'N/A'
  end
end
