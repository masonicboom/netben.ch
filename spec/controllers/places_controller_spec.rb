require 'spec_helper'

describe PlacesController do
  
  describe :show do
    
    it 'should fail if a place with the specified id does not exist' do
      BOGUS_place_ID = -1
      lambda do
        get :show, :id => @place
      end.should raise_error
    end
    
    context 'when the place exists, ' do
      
      before(:each) do
        @place = Factory.create(:place)
      end
      
      it 'should work' do
        get :show, :id => @place
        response.should be_success
      end
      
    end
    
  end

end
