class Member < ApplicationRecord

  belongs_to :city
  belongs_to :user

  validates :user_id, presence: true
  validates :city_id, presence: true
  validates :email, presence: true, uniqueness: true
  cattr_accessor :current_user

end
