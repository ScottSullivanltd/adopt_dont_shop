require "rails_helper"
RSpec.describe "the admins shelter index" do
  before :each do
    @shelter1 = Shelter.create!(name: "Pabus shelter", foster_program: true, city: "Erie", rank: 1)
    @shelter2 = Shelter.create!(name: "Lokis shelter", foster_program: true, city: "Denver", rank: 2)
    @shelter3 = Shelter.create!(name: "Ferret daycare", foster_program: true, city: "Chigago", rank: 3)
    @pet1 = @shelter1.pets.create!(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter1.id)
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 3, breed: "domestic pig", name: "Pabu", shelter_id: @shelter2.id)
    @application1 = Application.create!(name: "Pabu", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222, status: 1)
    @application2 = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222, status: 1)
    @application_pet = PetApplication.create!(pet_id: @pet1.id, application_id: @application2.id)
    @application_pet = PetApplication.create!(pet_id: @pet2.id, application_id: @application2.id)
  end
  it "has header for shelters" do
    visit "admin/shelters"
    expect(page).to have_content("Shelters in reverse alphabetical order")
  end
  it "lists all shelter" do
    visit "admin/shelters"
    within("#admin-shelters") do
      expect(page).to have_content(@shelter1.name)
      expect(page).to have_content(@shelter2.name)
      expect(page).to have_content(@shelter3.name)
    end
  end
  it "lists all shelters with a pending application" do
    visit "/admin/shelters"
    expect(page).to have_content("Shelters with pending applications")
    within("#pending-apps") do
      expect(page).to have_content(@shelter1.name)
    end
  end
end
