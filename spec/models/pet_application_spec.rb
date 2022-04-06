require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :application }
  end

  describe "validations" do
    it { should define_enum_for(:status).with_values(["Pending", "Approved", "Rejected"]) }
  end
end
