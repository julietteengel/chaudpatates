class CityPolicy < ApplicationPolicy

	def show?
    # TODO : if no public, only members and admin can see the page
    if record.public
      true
    else
      if user.present?
      member = Member.find_by_email(user.email)
      if (member.present? && member.city == record)
        true
      elsif user.id == record.admin
        true
      elsif user.admin?
        true
      else
        false
      end
    end
	end
end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
