require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe "validations" do
    it { should define_enum_for(:status).with_values(["In Progress", "Pending", "Approved", "Rejected"]) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_numericality_of(:zipcode) }
  end
end
