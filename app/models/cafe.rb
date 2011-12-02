class Cafe < ActiveRecord::Base
  has_many :test_results

  def Cafe::bandwidth_ranked
    Cafe.includes(:test_results).all.sort_by do |cafe|
      tr = cafe.test_results.find(:first, :order => 'upload_mbps * download_mbps DESC')
      tr.upload_mbps * tr.download_mbps
    end.reverse
  end

  def metrics(metric_name)
    test_results.select(metric_name).map {|r| r[metric_name]}
  end

end
