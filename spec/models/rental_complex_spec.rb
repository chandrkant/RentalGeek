require 'spec_helper'

describe RentalComplex do

  let(:rental_complex) { FactoryGirl.create(:rental_complex) }

=begin
  describe '#street_address_with_city' do
  
    context 'given a full_street_address ending with "Junction City, KS 66441"' do
    
      before { rental_complex.full_address = '728 W. 11th St., F, Junction City, KS 66441' }
      
      it("extracts the street address") { rental_complex.street_address_with_city.should eq('728 W. 11th St., F, Junction City') }
    end

    context 'given a full_street_address ending with "Manhattan,KS, 66502"' do
      
      before { rental_complex.full_address = '2420 Greenbriar Dr #A, Manhattan,KS, 66502' }
      
      it("extracts the street address") { rental_complex.street_address_with_city.should eq('2420 Greenbriar Dr #A, Manhattan') }
    end
  end
end

  describe '#street_name' do
  
    context 'given a full_street_address ending with "Junction City, KS 66441"' do
    
      before { rental_complex.full_address = '728 W. 11th St., F, Junction City, KS 66441' }
      
      it("extracts the street name") { rental_complex.street_name.should eq('W. 11th St.') }
    end

    context 'given a full_street_address ending with "Manhattan,KS, 66502"' do
      
      before { rental_complex.full_address = '2420 Greenbriar Dr #A, Manhattan,KS, 66502' }
      
      it("extracts the street name") { rental_complex.street_name.should eq('Greenbriar Dr') }
    end
=end
end
