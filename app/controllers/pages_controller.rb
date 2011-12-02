class PagesController < ApplicationController
  
  def home
    @ranked_cafes = Cafe::bandwidth_ranked(Cafe::near_to(37.7573, -122.4474))
  end
  
end
