class PagesController < ApplicationController
  
  def home
    @ranked_cafes = Cafe::bandwidth_ranked
  end
  
end
