class BenchesController < ApplicationController

  def create
    #raise ActiveRecord::RecordNotFound if params[:place][:google_id].nil?
    raise ActiveRecord::RecordNotFound if params[:place][:name].nil?
    raise ActiveRecord::RecordNotFound if params[:place][:latitude].nil?
    raise ActiveRecord::RecordNotFound if params[:place][:longitude].nil?
    #raise ActiveRecord::RecordNotFound if params[:bench][:upload_mbps].nil?
    raise ActiveRecord::RecordNotFound if params[:bench][:download_mbps].nil?
    #raise ActiveRecord::RecordNotFound if params[:bench][:loss_rate].nil?
    raise ActiveRecord::RecordNotFound if params[:bench][:ssid].nil?

    place = Place.find_by_google_id(params[:place][:google_id])
    if place.nil?
      place = Place.create(params[:place])
    end

    bench = place.benches.create(params[:bench])

    redirect_to(place)
  end

end
