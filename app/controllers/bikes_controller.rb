class BikesController < ApplicationController
  def index
    @bikes = Bike.includes(:customer).by_model
  end

  def show
    @bike = Bike.includes(:repairs).find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end