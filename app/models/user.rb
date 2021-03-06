class User < ApplicationRecord
# Added by Koudoku.
  has_one :subscription

  include Tokenable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:linkedin]

  has_one :city
  belongs_to :plan
  has_many :bookings, dependent: :destroy
  has_many :order
  has_attachment :photo
  # before_create :set_access_token
  # validates :promocode, presence: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :is_coach, inclusion: { in: [true,false] }
  validates :tickets_nb, presence: true, numericality: { only_integer: true }
  validates :phone,  :presence => {:message => 'Format incorrect'},
                     :numericality => true,
                     :allow_blank => true
  # validates_uniqueness_of :promocode

  scope :is_coach, -> { where(is_coach: true) }
  scope :is_admin, -> { where(groupe_admin: true) }
  scope :not_linked_to_city, -> { joins("LEFT OUTER JOIN cities ON cities.user_id = users.id").where("cities IS null") }

  after_create :send_welcome_email
  # after_create :check_if_promocode

  def self.find_for_linkedin_oauth(auth)
    user_params = auth.slice(:provider, :uid).to_h
    user_params.merge! auth.info.slice(:email, :first_name, :last_name, :headline)
    user_params[:linkedin_picture_url] = auth.info.image
    user_params[:linkedin_summary] = auth.extra.raw_info.summary
    user_params[:linkedin_profile] = auth.info.urls.public_profile
    user_params[:token] = auth.credentials.token
    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end
    return user
  end

  def has_photo?
    return false unless self.photo
    return true
    #self.photo.path.present?
  end

  def favorite_city
    unless self.bookings.empty?
      array_cities = self.bookings.includes(training: [:city]).map {|b| b.training.city }.group_by { |i| i }
      array_cities.max{ |x,y| x[1].length <=> y[1].length }.first
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_s
    self.email
  end

  def registrations_complete
    self.bookings.past.count
  end

  def badge
    if registrations_complete == 0
      :newbie
    elsif registrations_complete >= 1 and registrations_complete <= 3
      :regular
    elsif registrations_complete > 3 and registrations_complete < 6
      :advanced
    else
      :expert
    end
  end

  def subscribed?
    @subscription = Subscription.find_by_user_id(self.id)
    if @subscription.present? && @subscription.plan_id.present?
      true
    else
      false
    end
  end

  # def add_promocode_to_users_in_db
  #   User.where(promocode: :nil).each do |user|
  #     self.promocode = loop do
  #     random_token = SecureRandom.urlsafe_base64(nil, false)
  #     break random_token unless self.class.exists?(promocode: random_token)
  #     end
  #     user.save
  #     UserMailer.send_promocode(self)
  #   end
  # end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

  # def check_if_promocode
  #   raise
  #   unless invite_promocode.blank?
  #     if User.find_by_promocode(self.invite_promocode).present?
  #       user2 = User.find_by_promocode(invite_promocode)
  #       user2.tickets_nb += 1
  #       user2.save
  #       raise
  #     end
  #   end
  # end

  # def save_and_make_payment(plan, card_token)
  #   self.plan = plan
  #   if valid?
  #     begin
  #       customer = Stripe::Customer.create(
  #         source: card_token,
  #         plan: plan.stripe_id,
  #         email: email,
  #       )
  #       self.customer_id = customer.id
  #       self.plan_id = plan.id
  #       save(validate: false)
  #     rescue Stripe::CardError => e
  #       errors.add :credit_card, e.message
  #       false
  #     end
  #   else
  #     false
  #   end
  # end

end
