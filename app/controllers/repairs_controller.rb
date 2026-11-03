class RepairsController < ApplicationController
  before_action :set_repair, only: %i[show edit update destroy]

  def index
    @repairs = policy_scope(Repair).includes(
      bike: :customer,
      mechanic: [],
      taken_in_by: [],
      repair_line_items: :service_item,
      photos_attachments: { blob: { variant_records: :blob } },
      rich_text_diagnosis: []
    ).newest_first
  end

  def show
    authorize @repair
  end

  def new
    @repair = Repair.new(bike_id: params[:bike_id], dropped_off_at: Time.current)
    authorize @repair
    4.times { @repair.repair_line_items.build }
  end

  def edit
    authorize @repair
    2.times { @repair.repair_line_items.build }
  end

  def create
    @repair = Repair.new
    authorize @repair

    @repair.assign_attributes(repair_params.except(:photos))
    @repair.taken_in_by = Current.user
    new_photos = repair_params[:photos]&.reject(&:blank?)
    @repair.pending_photo_uploads = new_photos
    @repair.photos.attach(new_photos) if new_photos.present?

    if @repair.save
      redirect_to @repair, notice: "Repair for bike #{@repair.bike.serial_number} was created."
    else
      2.times { @repair.repair_line_items.build }
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @repair

    @repair.assign_attributes(repair_params.except(:photos))
    new_photos = repair_params[:photos]&.reject(&:blank?)
    @repair.pending_photo_uploads = new_photos
    @repair.photos.attach(new_photos) if new_photos.present?

    if @repair.save
      redirect_to @repair, notice: "Repair for bike #{@repair.bike.serial_number} was updated."
    else
      2.times { @repair.repair_line_items.build }
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @repair

    if @repair.destroy
      redirect_to repairs_path, notice: "Repair for bike #{@repair.bike.serial_number} was deleted.", status: :see_other
    else
      redirect_to @repair, alert: @repair.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_repair
    @repair = Repair.includes(
      bike: :customer,
      mechanic: [],
      taken_in_by: [],
      repair_line_items: :service_item,
      photos_attachments: { blob: { variant_records: :blob } },
      rich_text_diagnosis: []
    ).find(params[:id])
  end

  def repair_params
    params.require(:repair).permit(*permitted_attributes(@repair))
  end
end