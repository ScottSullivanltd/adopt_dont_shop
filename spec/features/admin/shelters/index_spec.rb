
require "rails_helper"

RSpec.describe "the admins shelter index" do
  before :each do
    @shelter1 = Shelter.create!(name: "Pabus shelter", foster_program: true, city: "Erie", rank: 1, )
    @shelter2 = Shelter.create!(name: "Lokis shelter", foster_program: true, city: "Denver", rank: 2)
    @shelter3 = Shelter.create!(name: "Ferret daycare", foster_program: true, city: "Chigago", rank: 3)
    @shelter4 = Shelter.create!(name: "Thors shelter", foster_program: true, city: "Erie", rank: 4)
    @shelter5 = Shelter.create!(name: "Ians shelter", foster_program: true, city: "Denver", rank: 5)
    @pet1 = @shelter1.pets.create!()
    @application1 = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222, status: 1)
    visit 'admin/shelters'
  end
  it "has header for shelters" do
    expect(page).to have_content("Shelters in reverse alphabetical order")
  end
  it "lists all shelter" do
    within("#admin-shelters") do
      expect(page).to have_content(@shelter1.name)
      expect(page).to have_content(@shelter2.name)
      expect(page).to have_content(@shelter3.name)
      expect(page).to have_content(@shelter4.name)
      expect(page).to have_content(@shelter5.name)
    end
  end
  it "lists all shelters with a pending application" do
    expect(page).to have_content("Shelters with pending applications")
    within("#pending-apps") do
      visit '/pets'
      
      expect(page).to have_content(@shelter1.name)
    end
  end
end
