require 'spec_helper'

describe Cafe do
  
  it 'should have a working factory' do
    Factory.create(:cafe)
  end
  
  describe 'Cafe::bandwidth_ranked' do
    
    it 'should return the fastest TestResult for this Cafe' do
      cafe1 = Factory.create(:cafe)
      result1 = Factory.create(:test_result, :cafe_id => cafe1.id, :download_mbps => 1.0, :upload_mbps => 1.0)
      result2 = Factory.create(:test_result, :cafe_id => cafe1.id, :download_mbps => 2.0, :upload_mbps => 2.0)
      
      cafe2 = Factory.create(:cafe)
      result3 = Factory.create(:test_result, :cafe_id => cafe2.id, :download_mbps => 3.0, :upload_mbps => 3.0)
      result4 = Factory.create(:test_result, :cafe_id => cafe2.id, :download_mbps => 4.0, :upload_mbps => 4.0)
      
      Cafe::bandwidth_ranked.should == [cafe2, cafe1]
    end
  end
  
end
