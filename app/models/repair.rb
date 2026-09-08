class Repair < ApplicationRecord
  STATUSES = %w[
    dropped_off
    in_diagnosis
    awaiting_decision
    in_progress
    ready_for_pickup
    collected
  ].freeze

  belongs_to :bike
  belongs_to :mechanic, optional: true

  has_many :repair_line_items, dependent: :restrict_with_error

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :dropped_off_at, presence: true

  validate :decision_required_before_work

  def overdue?
    promised_on.present? && promised_on < Date.current && status != "collected"
  end

  def move_to!(new_status)
    new_status = new_status.to_s

    unless allowed_transition?(new_status)
      errors.add(:status, "cannot transition from #{status} to #{new_status}")
      raise ActiveRecord::RecordInvalid, self
    end

    self.status = new_status
    save!
  end

  private

  def allowed_transition?(new_status)
    {
      "dropped_off" => %w[in_diagnosis in_progress],
      "in_diagnosis" => %w[awaiting_decision],
      "awaiting_decision" => %w[in_progress ready_for_pickup],
      "in_progress" => %w[ready_for_pickup],
      "ready_for_pickup" => %w[collected],
      "collected" => []
    }.fetch(status, []).include?(new_status)
  end

  def decision_required_before_work
    return unless status == "in_progress"
    return if decision.blank? || decision == "approved"

    errors.add(:decision, "cannot be declined when work is in progress")
  end
end