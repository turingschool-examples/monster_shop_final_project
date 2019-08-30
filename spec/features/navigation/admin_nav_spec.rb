require 'rails_helper'

RSpec.describe 'Nav Bar' do
  describe 'for an admin user ' do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 11234)
      @user = @bike_shop.users.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(true)
    end
    it 'i see the same links as a regular user except for cart' do
      image_url = "https://www.freepngimg.com/thumb/monster/34201-3-blue-monster-transparent-image-thumb.png"
      visit root_path

      within "nav" do
        expect(page).to have_css("img[src*='#{image_url}']")
        expect(page).to have_link("Items")
        expect(page).to have_link("Merchants")
        expect(page).to_not have_link("Cart: 0")
        expect(page).to have_link("Logout")
        expect(page).to have_link("My Profile")
        expect(page).to_not have_link("Login")
        expect(page).to_not have_link("Register")
      end

    end
    it 'i also see a link to my admin dashboard and link for all users' do
      visit root_path
      click_link "Admin Dashboard"
      expect(current_path).to eq("/admin")

      visit root_path
      click_link "All Users"
      expect(current_path).to eq("/admin/users")
    end
  end
end
