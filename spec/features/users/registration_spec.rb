# User Story 10, User Registration
#
# As a visitor
# When I click on the 'register' link in the nav bar
# Then I am on the user registration page ('/register')
# And I see a form where I input the following data:
# - my name
# - my street address
# - my city
# - my state
# - my zip code
# - my email address
# - my preferred password
# - a confirmation field for my password
#
# When I fill in this form completely,
# And with a unique email address not already in the system
# My details are saved in the database
# Then I am logged in as a registered user
# I am taken to my profile page ("/profile")
# I see a flash message indicating that I am now registered and logged in

require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when i click on register in the nav bar' do
    it 'I am on the user registration page and I can see a form' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
      allow_any_instance_of(ApplicationController).to receive(:current_user_merchant?).and_return(false)

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
  end
end
