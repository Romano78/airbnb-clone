class FlatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def update?
    user_authorization
  end

  def create?
    user_authorization
  end

  def destroy?
    user_authorization
  end

  private

  def user_authorization
    record.user == user || user.admin
  end
end
