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
  end
end
