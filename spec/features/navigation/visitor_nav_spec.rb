require 'rails_helper'

RSpec.describe 'Nav Bar' do
  describe 'restrictions for a visitor' do
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
      allow_any_instance_of(ApplicationController).to receive(:current_admin?).and_return(false)
      allow_any_instance_of(ApplicationController).to receive(:current_user_merchant?).and_return(false)
    end
    it 'I can not visit profile, merchant, or admin' do
      visit '/profile'
      expect(page.status_code).to eq(404)

      visit '/merchant'
      expect(page.status_code).to eq(404)

      visit '/admin'
      expect(page.status_code).to eq(404)
    end
  end

  describe 'for a visitor' do
    it 'has an icon for going home' do
      image_url = "https://www.freepngimg.com/thumb/monster/34201-3-blue-monster-transparent-image-thumb.png"
      visit root_path
      within "nav" do
        expect(page).to have_css("img[src*='#{image_url}']")
        find("img[src*='#{image_url}']").click
      end
      expect(current_path).to eq(root_path)
    end

    it 'has a link to see all items for sale' do
      visit root_path
      within "nav" do
        expect(page).to have_link("Items")
        click_on("Items")
      end
      expect(current_path).to eq(items_path)
    end

    it 'has a link to see all merchants' do
      visit root_path
      within "nav" do
        expect(page).to have_link("Merchants")
        click_on("Merchants")
      end
      expect(current_path).to eq(merchants_path)
    end

    it 'has a link to see cart' do
      visit root_path
      within "nav" do
        expect(page).to have_link("Cart: 0")
        click_on("Cart: 0")
      end
      expect(current_path).to eq(cart_path)
    end

    it 'has a link to login' do
      visit root_path
      within "nav" do
        expect(page).to have_link("Login")
        click_on("Login")
      end
      expect(current_path).to eq(login_path)
    end

    it 'has a link to register' do
      visit root_path
      within "nav" do
        expect(page).to have_link("Register")
        click_on("Register")
      end
      expect(current_path).to eq(register_path)
    end
    it 'doesnt have a link to profile' do
      visit root_path
      within "nav" do
        expect(page).to_not have_link("My Profile")
      end
    end
  end
end
