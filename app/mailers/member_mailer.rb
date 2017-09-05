class MemberMailer < ApplicationMailer

  def user_new_member(member)
    @member = member
    @city = member.city
    @user = User.find_by_email(@member.email)
    mail(to: @member.email, subject: "#{@member.user.full_name} vous invite aux cours privés: #{@member.city.name}")
  end

  def non_user_new_member(member)
    @member = member
    @city = member.city
    mail(to: @member.email, subject: "#{@member.user.full_name} vous invite aux cours privés: #{@member.city.name}")
  end

end
