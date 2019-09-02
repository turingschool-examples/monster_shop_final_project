require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'When I visit my profile page' do
    before(:each) do
      @user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc', password_confirmation: '123abc')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    end
    it 'I can see all of my profile data on the page except my password' do
      visit '/profile'

      expect(page).to have_content("Brian")
      expect(page).to have_content("123 Zanti St\nDenver, CO 80210")
      expect(page).to have_content("brian@hotmail.com")
      expect(page).to_not have_content("123abc")
    end

    it 'I see a link to edit my profile data' do
      visit '/profile'

      expect(page).to have_link "Edit Profile"
    end

    it 'The form to edit my info is already prepopulated except for password' do
      visit '/profile'

      click_link "Edit Profile"

      expect(current_path).to eq('/profile/edit')
      expect(find_field('Name').value).to eq("Brian")
      expect(find_field('Address').value).to eq("123 Zanti St")
      expect(find_field('City').value).to eq("Denver")
      expect(find_field('State').value).to eq("CO")
      expect(find_field('Zip').value).to eq("80210")
      expect(find_field('Email').value).to eq("brian@hotmail.com")
      expect(page).to_not have_field("Password")
    end

    it "I can edit profile info" do
      visit '/profile/edit'

      fill_in 'City', with:  "Honolulu"
      fill_in 'State', with:  "HI"
      fill_in 'Zip', with:  "10189"

      click_button "Update"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Profile updated successfully")
      expect(page).to have_content("123 Zanti St\nHonolulu, HI 10189")
    end

    it 'I can edit my password' do
      visit '/profile'

      click_link "Change Password"

      expect(current_path).to eq('/profile/edit_password')
      fill_in "Password", with: "123changepassword"
      fill_in "Password confirmation", with: "123changepassword"

      click_button "Change Password"

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Password updated successfully")
    end

    it 'I cant change password if fields dont match' do
      visit '/profile'

      click_link "Change Password"

      fill_in "Password", with: "123changepassword"
      fill_in "Password confirmation", with: "notmatching"

      click_button "Change Password"

      expect(page).to have_button("Change Password")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
# As a registered user
# When I visit my profile page
# I see a link to edit my password
# When I click on the link to edit my password
# I see a form with fields for a new password, and a new password confirmation
# When I fill in the same password in both fields
# And I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my password is updated
