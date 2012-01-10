require 'spec_helper'

describe BenchesController do
  
  describe :create do
    
    VALID_PARAMS = {
      :bench => {
        :download_mbps => 6.3,
        :ssid => 'linksys',
      },
      :place => {
        :google_id => '21341290ag93F',
        :name => 'Coffee House',
        :latitude => 37.7489,
        :longitude => -122.4281,
      },
    }
    
    it 'should fail without download_mbps' do
      params = Marshal.load(Marshal.dump(VALID_PARAMS))
      params[:bench][:download_mbps] = nil
      lambda do
        post :create, params
      end.should raise_error
    end
    
    it 'should fail without place name' do
      params = Marshal.load(Marshal.dump(VALID_PARAMS))
      params[:place][:name] = nil
      lambda do
        post :create, params
      end.should raise_error
    end
    
    it 'should fail without place latitude' do
      params = Marshal.load(Marshal.dump(VALID_PARAMS))
      params[:place][:latitude] = nil
      lambda do
        post :create, params
      end.should raise_error
    end
    
    it 'should fail without place longitude' do
      params = Marshal.load(Marshal.dump(VALID_PARAMS))
      params[:place][:longitude] = nil
      lambda do
        post :create, params
      end.should raise_error
    end
    
    it 'should fail without SSID' do
      params = Marshal.load(Marshal.dump(VALID_PARAMS))
      params[:bench][:ssid] = nil
      lambda do
        post :create, params
      end.should raise_error
    end
    
    context 'with valid params, ' do
      
      context 'when the specified place is not in the database yet, ' do
        
        before(:each) do
          places = Place.find_by_google_id(VALID_PARAMS[:place][:google_id])
          places.destroy_all unless places.nil?
        end
        
        it 'should create a place in the database' do
          lambda do
            post :create, VALID_PARAMS
          end.should change(Place, :count).by(1)
        end
        
        it 'should make a new bench record' do
          lambda do
            post :create, VALID_PARAMS
          end.should change(Bench, :count).by(1)
        end
        
        it 'should redirect to that new place page' do
          post :create, VALID_PARAMS
          place = Place.find_by_google_id(VALID_PARAMS[:place][:google_id])
          response.should redirect_to(place)
        end
        
      end
      
      context 'when the specified place is in the database, ' do
        
        before(:each) do
          @place = Factory.create(:place, :google_id => VALID_PARAMS[:place][:google_id], :name => VALID_PARAMS[:place][:name])
        end
        
        it 'should make a new bench record' do
          lambda do
            post :create, VALID_PARAMS
          end.should change(Bench, :count).by(1)
        end
        
        it 'should redirect to that place page' do
          post :create, VALID_PARAMS
          response.should redirect_to(@place)
        end
        
      end
    
    end
    
  end

end
