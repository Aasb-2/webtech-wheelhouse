class MechanicsController < ApplicationController
  before_action :set_mechanic, only: %i[show edit update destroy]

  def index
    @mechanics = policy_scope(Mechanic).by_name
  end

  def show
    authorize @mechanic
    @repairs = policy_scope(@mechanic.repairs).includes(
      bike: :customer,
      repair_line_items: :service_item,
      photos_attachments: { blob: { variant_records: :blob } },
      rich_text_diagnosis: []
    )
  end

  def new
    @mechanic = Mechanic.new
    authorize @mechanic
  end

  def edit
    authorize @mechanic
  end

  def create
    @mechanic = Mechanic.new(mechanic_params)
    authorize @mechanic

    if @mechanic.save
      redirect_to @mechanic, notice: "Mechanic #{@mechanic.name} was created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @mechanic

    if @mechanic.update(mechanic_params)
      redirect_to @mechanic, notice: "Mechanic #{@mechanic.name} was updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @mechanic

    if @mechanic.destroy
      redirect_to mechanics_path, notice: "Mechanic #{@mechanic.name} was deleted.", status: :see_other
    else
      redirect_to @mechanic, alert: @mechanic.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_mechanic
    @mechanic = Mechanic.includes(:repairs).find(params[:id])
  end

  def mechanic_params
    params.expect(mechanic: [:name])
  end
end