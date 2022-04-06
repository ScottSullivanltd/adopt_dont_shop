class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  enum status: {"In Progress" => 0, "Pending" => 1, "Approved" => 2, "Rejected" => 3}

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
