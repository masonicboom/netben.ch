class PagesController < ApplicationController

  def home
    @fastest_center_latitude, @fastest_center_longitude = 37.7630, -122.4313
    @ranked_cafes = Cafe::bandwidth_ranked(Cafe::near_to(@fastest_center_latitude, @fastest_center_longitude))
  end

end
