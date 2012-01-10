require 'spec_helper'

describe Place do
  
  it 'should have a working factory' do
    Factory.create(:place)
  end
  
  describe 'Place::bandwidth_ranked' do
    
    it 'should return the fastest bench for this Place' do
      place1 = Factory.create(:place)
      result1 = Factory.create(:bench, :place_id => place1.id, :download_mbps => 1.0, :upload_mbps => 1.0)
      result2 = Factory.create(:bench, :place_id => place1.id, :download_mbps => 2.0, :upload_mbps => 2.0)
      
      place2 = Factory.create(:place)
      result3 = Factory.create(:bench, :place_id => place2.id, :download_mbps => 3.0, :upload_mbps => 3.0)
      result4 = Factory.create(:bench, :place_id => place2.id, :download_mbps => 4.0, :upload_mbps => 4.0)
      
      Place::bandwidth_ranked.should == [place2, place1]
    end
  end
  
end
