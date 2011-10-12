class TestsController < ApplicationController
  
  def create
    raise ActiveRecord::RecordNotFound if params[:cafe][:google_id].nil?
    raise ActiveRecord::RecordNotFound if params[:cafe][:name].nil?
    raise ActiveRecord::RecordNotFound if params[:cafe][:latitude].nil?
    raise ActiveRecord::RecordNotFound if params[:cafe][:longitude].nil?
    raise ActiveRecord::RecordNotFound if params[:test_result][:upload_mbps].nil?
    raise ActiveRecord::RecordNotFound if params[:test_result][:download_mbps].nil?
    raise ActiveRecord::RecordNotFound if params[:test_result][:loss_rate].nil?
    
    cafe = Cafe.find_by_google_id(params[:cafe][:google_id])
    if cafe.nil?
      cafe = Cafe.create(params[:cafe])
    end
    
    cafe.test_results.create(params[:test_result])
    
    redirect_to(cafe)
  end
  
end
