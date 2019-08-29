# As a merchant employee or admin
# I see the same links as a regular user
# Plus the following links:
# - a link to my merchant dashboard ("/merchant")
require 'rails_helper'

RSpec.describe 'Nav Bar' do
  describe 'for a merchant user ' do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 11234)
      @user = @bike_shop.users.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:current_user_merchant).and_return(@user.merchant_id)
    end
    it 'i see the same links as a regular user' do
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

    end
    it 'i also see a link to my merchant dashboard' do
      visit root_path

      click_link "Merchant Dashboard"

      expect(current_path).to eq("/merchant")
    end
  end
end
