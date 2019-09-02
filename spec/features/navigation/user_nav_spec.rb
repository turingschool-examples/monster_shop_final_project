require 'rails_helper'

RSpec.describe 'Nav Bar' do
  describe 'for a registered user' do
    before(:each) do
      @user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')
      # allow_any_instance_of(ApplicationController).to receive(:current_user?).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'has restrictions for merchant and admin' do
      visit '/profile'
      expect(page.status_code).to eq(200)

      visit '/merchant'
      expect(page.status_code).to eq(404)

      visit '/admin'
      expect(page.status_code).to eq(404)
    end

    it 'has the same links as a visitor' do
      image_url = "https://www.freepngimg.com/thumb/monster/34201-3-blue-monster-transparent-image-thumb.png"
      visit root_path

      within "nav" do
        expect(page).to have_css("img[src*='#{image_url}']")
        expect(page).to have_link("Items")
        expect(page).to have_link("Merchants")
        expect(page).to have_link("Cart: 0")
        expect(page).to have_link("Logout")
        expect(page).to have_link("My Profile")
        expect(page).to_not have_link("Login")
        expect(page).to_not have_link("Register")
      end
      expect(page).to have_content("Logged in as #{@user.name}")
    end

    it 'has logout path that links correctly' do
      visit root_path

      within "nav" do
        click_link "Logout"
      end

      expect(current_path).to eq(root_path)
    end

    it 'has profile path that links correctly' do
      visit root_path

      within "nav" do
        click_link "My Profile"
      end

      expect(current_path).to eq("/profile")
    end
  end
end
