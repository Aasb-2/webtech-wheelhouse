class BikesController < ApplicationController
  def index
    @bikes = Bike.includes(:customer).order(:model)
  end

  def show
    @bike = Bike.includes(:repairs).find(params[:id])
  end
end