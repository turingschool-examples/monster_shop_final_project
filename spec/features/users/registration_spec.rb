require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when i click on register in the nav bar' do
    it 'I am on the user registration page and I can see a form' do
      visit '/'
      click_on "Register"

      expect(current_path).to eq(register_path)
      expect(page).to have_content("User Registration")
      expect(page).to have_field("Name")
      expect(page).to have_field("Address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zip")
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
      expect(page).to have_field("Password confirmation")
    end

    it 'I am logged in and taken to profile page where I can see a flash message' do

      visit '/register'

      fill_in "Name", with: "Mike"
      fill_in "Address", with: "123 Dao St."
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zip", with: 80203
      fill_in "Email", with: "mdao@gmail.com"
      fill_in "Password", with: "AthenaIsTheBest"
      fill_in "Password confirmation", with: "AthenaIsTheBest"

      click_button "Register"

      new_user = User.last

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Mike, you are now registered and logged in.")
    end

    it 'I can only create user if i have a unique email' do
      @user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

      visit '/register'

      fill_in "Name", with: "Brian"
      fill_in "Address", with: "123 OtherBrian St."
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zip", with: 80203
      fill_in "Email", with: "brian@hotmail.com"
      fill_in "Password", with: "climbingiscool"
      fill_in "Password confirmation", with: "climbingiscool"

      click_button "Register"

      expect(page).to have_button('Register')
      expect(page).to have_content("There is already a user that exists with this email.")
    end
  end
end
