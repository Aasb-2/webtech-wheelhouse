class MechanicPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.owner?
  end

  def update?
    user.owner?
  end

  def destroy?
    user.owner?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end