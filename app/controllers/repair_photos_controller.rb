class RepairPhotosController < ApplicationController
  before_action :set_repair

  def destroy
    photo = @repair.photos.find(params[:id])
    photo.purge
    redirect_to @repair, notice: "Photo removed.", status: :see_other
  end

  private

  def set_repair
    @repair = Repair.find(params[:repair_id])
  end
end