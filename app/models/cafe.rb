class Cafe < ActiveRecord::Base
  has_many :test_results

  def Cafe::bandwidth_ranked
    Cafe.joins(:test_results).find(:all, :order => 'upload_mbps * download_mbps DESC', :group => 'cafe_id')
  end
  
end
