require "rails_helper"

RSpec.describe "show new pet adoption application", type: :feature do
  it "can search for pets by keyword" do
    application = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222)

    visit "/applications/#{application.id}"

    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_button("Search")
  end

  it "returns matched search results" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: shelter.id)
    application = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222)

    visit "/applications/#{application.id}"

    fill_in "Pet Name:", with: "Babe"
    click_on("Search")

    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_3.name)
  end

  it "adds a pet to the application" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: shelter.id)
    application = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222)

    visit "/applications/#{application.id}"

    fill_in "Pet Name:", with: "Babe"
    click_button("Search")

    click_button("Adopt this Pet")

    expect(page).to have_current_path("/applications/#{application.id}")
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_3.name)
  end
end
