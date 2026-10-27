class Repair < ApplicationRecord
  STATUSES = %w[dropped_off in_diagnosis awaiting_decision in_progress ready_for_pickup collected].freeze
  DECISIONS = %w[approved declined assumed_approved].freeze
  PHOTO_MAX_SIZE = 5.megabytes
  ALLOWED_PHOTO_TYPES = %w[image/jpeg image/png].freeze

  belongs_to :bike
  belongs_to :mechanic, optional: true
   belongs_to :taken_in_by, class_name: "User", optional: true

  has_many :repair_line_items, dependent: :destroy
  has_many :services, through: :repair_line_items, source: :service_item

  has_many_attached :photos do |attachable|
    attachable.variant :thumb, resize_to_fill: [150, 150]
    attachable.variant :large, resize_to_limit: [800, 800]
  end
  has_rich_text :diagnosis

  accepts_nested_attributes_for :repair_line_items,
    allow_destroy: true,
    reject_if: proc { |attributes| attributes["service_item_id"].blank? }

  attr_accessor :pending_photo_uploads

  validates :bike, presence: true
  validates :dropped_off_at, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :decision, inclusion: { in: DECISIONS }, allow_nil: true

  validate :valid_status_transition
  validate :collected_and_promised_not_before_dropped_off
  validate :decision_recorded_once_work_has_started
  validate :pending_photos_are_valid_images

  before_validation :nilify_blank_decision
  before_validation :set_collected_at, if: -> { status == "collected" && collected_at.blank? }

  scope :open, -> { where.not(status: :collected) }
  scope :overdue, -> { open.where(promised_on: ...Date.current) }
  scope :newest_first, -> { order(dropped_off_at: :desc) }

  STATUSES.each do |status_name|
    scope status_name, -> { where(status: status_name) }
    define_method("#{status_name}?") do
      status == status_name
    end
  end

  def overdue?
    !collected? && promised_on.present? && promised_on < Date.current
  end

  def total
    repair_line_items.sum(&:price_charged)
  end

  def move_to!(new_status)
    @transition_from = self.status
    self.status = new_status
    self.collected_at = Time.current if new_status.to_s == "collected"
    save!
  ensure
    @transition_from = nil
  end

  private

  def valid_status_transition
    return if @transition_from.nil?

    old_status = @transition_from.to_s
    new_status = status.to_s

    return if old_status == new_status

    allowed = case old_status
              when "dropped_off"
                %w[in_diagnosis awaiting_decision in_progress ready_for_pickup]
              when "in_diagnosis"
                %w[awaiting_decision in_progress ready_for_pickup]
              when "awaiting_decision"
                if decision == "approved" || decision == "assumed_approved"
                  %w[in_progress]
                elsif decision == "declined"
                  %w[ready_for_pickup]
                else
                  []
                end
              when "in_progress"
                %w[ready_for_pickup]
              when "ready_for_pickup"
                %w[collected]
              when "collected"
                []
              else
                []
              end

    unless allowed.include?(new_status)
      errors.add(:status, "cannot transition from #{old_status} to #{new_status}")
    end
  end

  def set_collected_at
    self.collected_at = Time.current
  end

  def nilify_blank_decision
    self.decision = nil if decision.blank?
  end

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
    if status != "collected" && collected_at.present?
      errors.add(:collected_at, "can't be set unless the repair has been collected")
    end
  end

  def pending_photos_are_valid_images
    Array(pending_photo_uploads).each do |file|
      sniffed_type = Marcel::MimeType.for(file.tempfile)

      unless ALLOWED_PHOTO_TYPES.include?(sniffed_type)
        errors.add(:photos, "#{file.original_filename} must be a JPEG or PNG image")
      end

      if file.tempfile.size > PHOTO_MAX_SIZE
        errors.add(:photos, "#{file.original_filename} is larger than #{PHOTO_MAX_SIZE / 1.megabyte}MB")
      end
    end
  end
end