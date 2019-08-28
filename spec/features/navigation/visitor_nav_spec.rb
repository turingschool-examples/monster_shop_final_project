# As a visitor
# I see a navigation bar
# This navigation bar includes links for the following:
# - a link to log in ("/login")
# - a link to the user registration page ("/register")
require 'rails_helper'

RSpec.describe 'Nav Bar' do
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
  end
end
