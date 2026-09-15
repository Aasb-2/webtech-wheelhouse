class ServiceItemsController < ApplicationController
  def index
    @service_items = ServiceItem.order(:name)
  end

  def show
    @service_item = ServiceItem.find(params[:id])
  end
end