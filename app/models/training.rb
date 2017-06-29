class Training < ApplicationRecord

  LEVELS = ['Patator', 'Patate Douce', 'Tous niveaux']
  INOUTDOORS = ['Indoor', 'Outdoor', 'En fonction de la météo']
  belongs_to :city
  belongs_to :location
  belongs_to :session
  has_many :bookings, dependent: :destroy
  validates :city_id, :date, presence: true
  #validates :location, :public_description, :private_description, presence: true, on: :update
  #validates :public_description, :private_description, length: { minimum: 140 }, on: :update
  validate :date_cannot_be_in_the_past, on: :create
  # validates :level, presence: true
  # validates :inoutdoor, presence:true
  # validates_inclusion_of :level, :in => LEVELS
  # validate :date_has_to_be_in_session

  scope :session_is, -> (session) { where(session: session) }
  scope :past, -> { where("date < ?", (Time.now)) }
  scope :upcoming_plus_30min, -> { where("date >= ?", (Time.now - 30.minutes)) }
  scope :upcoming, -> { where("date >= ?", (Time.now + 1.hours)) }
  scope :city, -> (city) { where( city: city) }
  # scope :week, -> { where("date >= ?", (Time.now))}
  scope :week, -> { where('date BETWEEN ? AND ?', Time.now, Time.now + 7.days) }


  has_attachment :photo

  before_destroy :notify_user_for_cancellation, prepend: true
  # before_destroy :refund_user, prepend: true
  after_commit :notify_member_before_training, on: :create
  # after_create :notify_non_member_before_training

  def booked_by?(user)
    user.bookings.each do |booking|
      return true if booking.training == self
    end
    return false
  end

  def number_of_participants
    self.bookings.count
  end

  def date_cannot_be_in_the_past
    return if date > Date.today
    errors.add(:date, 'Merci de sélectionner une date dans le futur')
  end

  def members
    members = []
    self.bookings.each { |booking| members << booking.user }
    return members
  end

  def next_trainings(number)
    r = self.includes(:location).upcoming_plus_30min.city(self).order(:date).first(number)
    r.length == 1 ? r.first : r
  end

  # def date_has_to_be_in_session
  # 	sessions_day = []
  # 	city.sessions.each { |session| sessions_day << session.day }
  # 	return if sessions_day.include?(date.strftime("%A")) && city.sessions.find_by(day: date.strftime("%A")).time_of_day.strftime("%H:%M") == date.strftime("%H:%M")
  #   errors.add(:date, I18n.t('activerecord.errors.messages.sessions'))
  # end

  def to_s
    "#{self.date}, #{self.city.name}"
  end

  def notify_user_for_cancellation
    TrainingMailer.cancellation(self).deliver_now
  end

  def notify_member_before_training
    TrainingMailer.reminder_if_registered(self).deliver_later(wait_until: self.date - 1.hour)
    # NOOO : BookingMailer.delay_until(training.date - 2.days).upcoming(self)
  end

  # def notify_non_member_before_training
  #   TrainingMailer.reminder_if_not_registered(self).deliver_later(wait_until: self.date - 1.day)
  #   # NOOO : BookingMailer.delay_until(training.date - 2.days).upcoming(self)
  # end

  def send_lastmin_info
    # TrainingMailer.send_lastmin_info(self).deliver_now
  end

end
