class CustomersController < ApplicationController
  def index
    @customers = Customer.by_name
  end

  def show
    @customer = Customer.includes(:bikes).find(params[:id])
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