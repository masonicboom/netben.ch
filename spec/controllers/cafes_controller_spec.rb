require 'spec_helper'

describe CafesController do
  
  describe :show do
    
    it 'should fail if a cafe with the specified id does not exist' do
      BOGUS_CAFE_ID = -1
      lambda do
        get :show, :id => @cafe
      end.should raise_error
    end
    
    context 'when the Cafe exists, ' do
      
      before(:each) do
        @cafe = Factory.create(:cafe)
      end
      
      it 'should work' do
        get :show, :id => @cafe
        response.should be_success
      end
      
    end
    
  end

end
