class Repair < ApplicationRecord
  belongs_to :bike
  belongs_to :mechanic, optional: true

  has_many :repair_line_items, dependent: :destroy
  has_many :services, through: :repair_line_items, source: :service_item

  enum :status, {
    dropped_off: "dropped_off",
    in_diagnosis: "in_diagnosis",
    awaiting_decision: "awaiting_decision",
    in_progress: "in_progress",
    ready_for_pickup: "ready_for_pickup",
    collected: "collected"
  }, default: "dropped_off"

  DECISIONS = %w[approved declined assumed_approved].freeze

  validates :bike, presence: true
  validates :dropped_off_at, presence: true
  validates :status, presence: true
  validates :decision, inclusion: { in: DECISIONS }, allow_nil: true

  validate :collected_and_promised_not_before_dropped_off
  validate :decision_recorded_once_work_has_started

  scope :open, -> { where.not(status: :collected) }
  scope :overdue, -> { open.where(promised_on: ...Date.current) }
  scope :newest_first, -> { order(dropped_off_at: :desc) }

  def overdue?
    !collected? && promised_on.present? && promised_on < Date.current
  end

  def total
    repair_line_items.sum(:price_charged)
  end

  private

  def collected_and_promised_not_before_dropped_off
    return if dropped_off_at.blank?

    if collected_at.present? && collected_at < dropped_off_at
      errors.add(:collected_at, "can't be before the bike was dropped off")
    end

    if promised_on.present? && promised_on < dropped_off_at.to_date
      errors.add(:promised_on, "can't be before the bike was dropped off")
    end
  end

  def decision_recorded_once_work_has_started
    if %w[in_progress ready_for_pickup collected].include?(status) && decision.blank?
      errors.add(:decision, "must be recorded before work starts")
    end

    if status == "collected" && collected_at.blank?
      errors.add(:collected_at, "must be recorded once a repair is collected")
    end

    if status != "collected" && collected_at.present?
      errors.add(:collected_at, "can't be set unless the repair has been collected")
    end
  end
end