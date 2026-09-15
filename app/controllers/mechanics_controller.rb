class MechanicsController < ApplicationController
  def index
    @mechanics = Mechanic.order(:name)
  end

  def show
    @mechanic = Mechanic.includes(:repairs).find(params[:id])
  end
end