class RepairsController < ApplicationController
  def index
    @repairs = Repair.includes(:bike, :mechanic).order(dropped_off_at: :desc)
  end

  def show
    @repair = Repair.includes(:bike, :mechanic, repair_line_items: :service_item).find(params[:id])
  end
end