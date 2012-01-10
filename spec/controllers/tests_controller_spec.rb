require 'spec_helper'

describe TestsController do
  
  describe :create do
    
    VALID_PARAMS = {
      :test_result => {
        :download_mbps => 6.3,
        :ssid => 'linksys',
      },
      :cafe => {
        :google_id => '21341290ag93F',
        :name => 'Coffee House',
        :latitude => 37.7489,
        :longitude => -122.4281,
      },
    }
    
    it 'should fail without download_mbps' do
      params = Marshal.load(Marshal.dump(VALID_PARAMS))
      params[:test_result][:download_mbps] = nil
      lambda do
        post :create, params
      end.should raise_error
    end
    
    it 'should fail without cafe name' do
      params = Marshal.load(Marshal.dump(VALID_PARAMS))
      params[:cafe][:name] = nil
      lambda do
        post :create, params
      end.should raise_error
    end
    
    it 'should fail without cafe latitude' do
      params = Marshal.load(Marshal.dump(VALID_PARAMS))
      params[:cafe][:latitude] = nil
      lambda do
        post :create, params
      end.should raise_error
    end
    
    it 'should fail without cafe longitude' do
      params = Marshal.load(Marshal.dump(VALID_PARAMS))
      params[:cafe][:longitude] = nil
      lambda do
        post :create, params
      end.should raise_error
    end
    
    it 'should fail without SSID' do
      params = Marshal.load(Marshal.dump(VALID_PARAMS))
      params[:test_result][:ssid] = nil
      lambda do
        post :create, params
      end.should raise_error
    end
    
    context 'with valid params, ' do
      
      context 'when the specified Cafe is not in the database yet, ' do
        
        before(:each) do
          cafes = Cafe.find_by_google_id(VALID_PARAMS[:cafe][:google_id])
          cafes.destroy_all unless cafes.nil?
        end
        
        it 'should create a Cafe in the database' do
          lambda do
            post :create, VALID_PARAMS
          end.should change(Cafe, :count).by(1)
        end
        
        it 'should make a new TestResult record' do
          lambda do
            post :create, VALID_PARAMS
          end.should change(TestResult, :count).by(1)
        end
        
        it 'should redirect to that new Cafe page' do
          post :create, VALID_PARAMS
          cafe = Cafe.find_by_google_id(VALID_PARAMS[:cafe][:google_id])
          response.should redirect_to(cafe)
        end
        
      end
      
      context 'when the specified Cafe is in the database, ' do
        
        before(:each) do
          @cafe = Factory.create(:cafe, :google_id => VALID_PARAMS[:cafe][:google_id], :name => VALID_PARAMS[:cafe][:name])
        end
        
        it 'should make a new TestResult record' do
          lambda do
            post :create, VALID_PARAMS
          end.should change(TestResult, :count).by(1)
        end
        
        it 'should redirect to that Cafe page' do
          post :create, VALID_PARAMS
          response.should redirect_to(@cafe)
        end
        
      end
    
    end
    
  end

end
