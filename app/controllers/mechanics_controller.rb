class MechanicsController < ApplicationController
  def index
    @mechanics = Mechanic.by_name
  end

  def show
    @mechanic = Mechanic.includes(:repairs).find(params[:id])
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