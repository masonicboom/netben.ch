class PagesController < ApplicationController

  def home
    @fastest_center_latitude, @fastest_center_longitude = 37.7630, -122.4313
    @rankings = Place::bandwidth_ranked(Place::near_to(@fastest_center_latitude, @fastest_center_longitude))
  end

end
