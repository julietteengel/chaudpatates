class Location < ApplicationRecord
	has_many :trainings

	ADDRESSLENGTH = 5..150

	scope :city, -> (city) { where("lower(address) LIKE ?", "%#{city.name.downcase}%") }

	validates :name, presence: true
	validates :photo, presence: true
	validates :address, presence: true, length: { in: ADDRESSLENGTH }
  validates :public_description, :private_description, presence: true
  validates :public_description, :private_description, length: { minimum: 140 }

	has_attachment :photo

	geocoded_by :full_address
	after_validation :geocode

	def select_label
    "#{self.name}, #{self.address}"
  end

  private

  def full_address
  	self.address
  end

end
