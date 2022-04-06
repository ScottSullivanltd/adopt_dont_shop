
require "rails_helper"

RSpec.describe "the admins application show" do
  before :each do
    @shelter1 = Shelter.create!(name: "Pabus shelter", foster_program: true, city: "Erie", rank: 1, )
    @shelter2 = Shelter.create!(name: "Lokis shelter", foster_program: true, city: "Denver", rank: 2)

    @pet1 = @shelter1.pets.create!(adoptable: true, age: 3, breed: "domestic pig", name: "Loki", shelter_id: @shelter1.id)
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 3, breed: "domestic pig", name: "Pabu", shelter_id: @shelter2.id)

    @application1 = Application.create!(name: "Ian", street_address: "123 Ferret St", city: "Erie", state: "CO", zipcode: 80516, status: "Pending")
    @application2 = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222, status: "In Progress")

    @application_pet = PetApplication.create!(pet_id: @pet1.id, application_id: @application1.id)
    @application_pet = PetApplication.create!(pet_id: @pet2.id, application_id: @application1.id)

    visit "admin/applications/#{@application1.id}"
  end
  it "has header" do
    expect(page).to have_content("#{@application1.name}'s Application")
  end
  it "lists each pet in application" do
    within("#pet-#{@pet1.id}") do
      expect(page).to have_content("Loki")
    end
    within("#pet-#{@pet2.id}") do
      expect(page).to have_content("Pabu")
    end
  end
  it "has button to approve application for pet" do
    within("#pet-#{@pet1.id}") do
      save_and_open_page
      click_button "Approve #{@pet1.name}"
      expect(page).to have_current_path("/admin/applications/#{@application1.id}")
      expect(page).to_not have_button("Approve #{@pet1.name}")
      expect(page).to have_content("#{@pet1.name} has been approved")
    end
    within("#pet-#{@pet2.id}") do
      click_button "Approve #{@pet2.name}"
      expect(page).to have_current_path("a/dmin/applications/#{@application1.id}")
      expect(page).to_not have_button("Approve #{@pet2.name}")
      expect(page).to have_content("#{@pet2.name} has been approved")
    end
  end
end
