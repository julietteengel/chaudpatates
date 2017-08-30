class CityPolicy < ApplicationPolicy

	def show?
    # TODO : if public, only members and admin can see the page
		true
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
