class City < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :user
  has_many :sessions, dependent: :destroy
  has_many :trainings, dependent: :destroy

  alias_attribute :coach, :user
  alias_attribute :coach=, :user=

  validates :name, presence: true, uniqueness: true
  validates :photo, presence: true
  validates :user_id, presence: true


  has_attachment :photo

  def next_trainings(number)
    r = Training.includes(:location).upcoming.city(self).order(:date).first(number)
    r.length == 1 ? r.first : r
  end

  def find_city_members
    # If you want to include an association (we'll call it bookings) of an already included association
    # (we'll call it Trainig), you'd use the syntax above. However, if you'd like to include Users as well,
    # which is also an association of Bookings
    trainings = Training.includes({ bookings: [:user] }).city(self)
    bookings = []
    trainings.each do |training|
      training.bookings.each do |booking|
        bookings << booking
      end
    end
    bookings.map { |booking| booking.user}.uniq[0..10]
  end

  def trainings_not_booked_by(user)
    trainings = self.next_trainings(6)
    user.bookings.includes(:training).each do |booking|
      trainings.delete(booking.training) if trainings.include?(booking.training)
    end
    trainings
  end

end
