require 'rails_helper'

RSpec.describe 'applications show page' do
  before :each do
    @application = Applications.create!(name: "Pabu", street_address: "123 Ferret St", city: "Erie", state: "Co", zipcode: "80516", description: "Am animal")
    @shelter = Shelter.create!(foster_program: true, name: "Pabus sheter", city: "Erie", rank: 1)
    @pet1 = @application.pets.create!(adoptable: true, age: 2, breed: "Ferret", name: "Loki", shelter_id: @shelter.id)

    visit "applications/#{@application.id}"
  end

  it 'shows applications attributes' do
    within('#full-address') do
      expect(page).to have_content(@application.street_address)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.state)
      expect(page).to have_content(@application.zipcode)
    end
    within('#description') do
      expect(page).to have_content(@application.description)
    end
    within("#pets") do

    end
    within("#status") do

    end
  end
end
