class BikePolicy < ApplicationPolicy
  def index?
    staff_member?
  end

  def show?
    staff_member?
  end

  def create?
    staff_member?
  end

  def update?
    staff_member?
  end

  def destroy?
    user&.owner?
  end

  private

  def staff_member?
    user&.owner? || user&.counter?
  end

  class Scope < Scope
    def resolve
      if user.owner? || user.counter?
        scope.all
      else
        scope.none
      end
    end
  end
end