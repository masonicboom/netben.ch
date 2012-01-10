class Place < ActiveRecord::Base
  has_many :benches

  # TODO: do the actual math. The conversion of longitude to units of distance varies with longitude, so this is a hack.
  def Place::near_to(latitude, longitude, bbox_width_degrees=1/7.0, bbox_height_degrees=2/7.0)
    a = bbox_height_degrees/2.0
    b = bbox_width_degrees/2.0
    Place.where(:latitude => (latitude-a)..(latitude+a), :longitude => (longitude-b)..(longitude+b))
  end

  def Place::bandwidth_ranked(places=Place.includes(:benches).all)
    places.sort_by do |place|
      tr = place.benches.find(:first, :order => 'upload_mbps * download_mbps DESC')
      tr.download_mbps
    end.reverse
  end

  def metrics(metric_name)
    benches.select(metric_name).map {|r| r[metric_name]}
  end

end
