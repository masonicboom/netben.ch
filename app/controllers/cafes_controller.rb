class CafesController < ApplicationController
  
  def show
    @cafe = Cafe.find(params[:id])
  end
  
end
