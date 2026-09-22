class RepairsController < ApplicationController
  def index
    @repairs = Repair.includes(:bike, :mechanic).newest_first
  end

  def show
    @repair = Repair.includes(:bike, :mechanic, repair_line_items: :service_item).find(params[:id])
  end
end