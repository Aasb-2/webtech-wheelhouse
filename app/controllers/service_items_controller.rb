class ServiceItemsController < ApplicationController
  def index
    @service_items = ServiceItem.by_name
  end

  def show
    @service_item = ServiceItem.find(params[:id])
  end
end