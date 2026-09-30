class ServiceItemsController < ApplicationController
  before_action :set_service_item, only: %i[show edit update destroy]

  def index
    @service_items = ServiceItem.by_name
  end

  def show
  end

  def new
    @service_item = ServiceItem.new
  end

  def edit
  end

  def create
    @service_item = ServiceItem.new(service_item_params)
    if @service_item.save
      redirect_to @service_item, notice: "Service #{@service_item.name} was created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @service_item.update(service_item_params)
      redirect_to @service_item, notice: "Service #{@service_item.name} was updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @service_item.destroy
      redirect_to service_items_path, notice: "Service #{@service_item.name} was deleted.", status: :see_other
    else
      redirect_to @service_item, alert: @service_item.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_service_item
    @service_item = ServiceItem.find(params[:id])
  end

  def service_item_params
    params.expect(service_item: [:name, :current_price])
  end
end