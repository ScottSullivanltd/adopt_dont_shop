require "rails_helper"

RSpec.describe "show new pet adoption application", type: :feature do
  it "can search for pets by keyword" do
    application = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222)

    visit "/applications/#{application.id}"

    within "#add_pets" do
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_button("Search")
    end
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

    within "#add_pets" do
      expect(page).to have_content(pet_2.name)
      expect(page).to_not have_content(pet_1.name)
      expect(page).to_not have_content(pet_3.name)
    end
  end

  it "returns partially matched search results" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: shelter.id)
    application = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222)

    visit "/applications/#{application.id}"

    fill_in "Pet Name:", with: "Ba"
    click_on("Search")

    within "#add_pets" do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to_not have_content(pet_3.name)
    end
  end

  it "returns case insensitive matched search results" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "bAre-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: shelter.id)
    application = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222)

    visit "/applications/#{application.id}"

    fill_in "Pet Name:", with: "ba"
    click_on("Search")

    within "#add_pets" do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to_not have_content(pet_3.name)
    end
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

    within "#adopt_pets" do
      expect(page).to have_current_path("/applications/#{application.id}")
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.age)
      expect(page).to have_content(pet_2.breed)
      expect(page).to_not have_content(pet_1.name)
      expect(page).to_not have_content(pet_1.age)
      expect(page).to_not have_content(pet_1.breed)
      expect(page).to_not have_content(pet_3.name)
      expect(page).to_not have_content(pet_3.age)
      expect(page).to_not have_content(pet_3.breed)
    end
  end

  it "submits the application" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: shelter.id)
    application = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222)

    visit "/applications/#{application.id}"

    fill_in :search, with: "Babe"
    click_button("Search")

    click_button("Adopt this Pet")

    fill_in :description, with: "I love animals"

    click_button("Submit Adoption Application")

    within "#adopt_pets" do
      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.age)
      expect(page).to have_content(pet_2.breed)
    end
    within "#submit" do
      expect(page).to have_content("Pending")
      expect(page).to_not have_content("Adopt this Pet")
    end
  end

  it "shows a completed application with no text fields or buttons" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: shelter.id)
    application = Application.create!(name: "John Smith", street_address: "321 Main St", city: "Denver", state: "CO", zipcode: 80222)

    visit "/applications/#{application.id}"

    fill_in :search, with: "Babe"
    click_button("Search")

    click_button("Adopt this Pet")

    fill_in :description, with: "I love animals"

    click_button("Submit Adoption Application")

    expect(current_path).to eq("/applications/#{application.id}")
    within "#applicant" do
      expect(page).to have_content("John Smith")
      expect(page).to have_content("321 Main St")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content(80222)
    end
    within "#adopt_pets" do
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.age)
      expect(page).to have_content(pet_2.breed)
    end
    within "#submit" do
      expect(page).to have_content("I love animals")
      expect(page).to have_content("Pending")
      expect(page).to_not have_content("Search")
      expect(page).to_not have_content("Adopt this Pet")
      expect(page).to_not have_content("Submit Adoption Application")
    end
  end
end
