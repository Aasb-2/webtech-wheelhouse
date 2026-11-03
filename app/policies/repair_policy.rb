class RepairPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.owner? || user.counter? || assigned_to_user?
  end

  def create?
    user.owner? || user.counter?
  end

  def update?
    return true if user.owner?
    return false if record.collected?

    user.counter? || assigned_to_user?
  end

  def destroy?
    user.owner?
  end

  def permitted_attributes
    if user.owner? || user.counter?
      [
        :bike_id, :mechanic_id, :status, :decision, :promised_on, :dropped_off_at, :collected_at,
        :diagnosis,
        { repair_line_items_attributes: [:id, :service_item_id, :price_charged, :_destroy] },
        { photos: [] }
      ]
    elsif user.mechanic?
      [:status, :diagnosis, { photos: [] }]
    else
      []
    end
  end

  def may_edit?(field)
    permitted_attributes.any? do |attribute|
      attribute == field || (attribute.is_a?(Hash) && attribute.key?(field))
    end
  end

  private

  def assigned_to_user?
    user.mechanic? && user.mechanic_id.present? && record.mechanic_id == user.mechanic_id
  end

  class Scope < Scope
    def resolve
      return scope.all unless user.mechanic?
      return scope.none if user.mechanic_id.nil?

      scope.where(mechanic_id: user.mechanic_id)
    end
  end
end