class Cafe < ActiveRecord::Base
  has_many :test_results

  # TODO: do the actual math. The conversion of longitude to units of distance varies with longitude, so this is a hack.
  def Cafe::near_to(latitude, longitude, bbox_width_degrees=1/7.0, bbox_height_degrees=2/7.0)
    a = bbox_height_degrees/2.0
    b = bbox_width_degrees/2.0
    Cafe.where(:latitude => (latitude-a)..(latitude+a), :longitude => (longitude-b)..(longitude+b))
  end

  def Cafe::bandwidth_ranked(cafes=Cafe.includes(:test_results).all)
    cafes.sort_by do |cafe|
      tr = cafe.test_results.find(:first, :order => 'upload_mbps * download_mbps DESC')
      tr.download_mbps
    end.reverse
  end

  def metrics(metric_name)
    test_results.select(metric_name).map {|r| r[metric_name]}
  end

end
