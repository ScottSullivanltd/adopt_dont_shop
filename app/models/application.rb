class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  enum status: {"In Progress" => 0, "Pending" => 1, "Approved" => 2, "Rejected" => 3}
end
