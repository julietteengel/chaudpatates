class OrderPolicy < ApplicationPolicy

  def index?
    true
  end

	def create?
    @record.user == user
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
