class ServiceItemsController < ApplicationController
  def index
    @service_items = ServiceItem.by_name
  end

  def show
    @service_item = ServiceItem.find(params[:id])
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