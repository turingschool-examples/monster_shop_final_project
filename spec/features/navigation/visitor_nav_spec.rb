# As a visitor
# I see a navigation bar
# This navigation bar includes links for the following:
# - a link to return to the welcome / home page of the application ("/")
# - a link to browse all items for sale ("/items")
# - a link to see all merchants ("/merchants")
# - a link to my shopping cart ("/cart")
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
        expect(current_path).to eq(root_path)
      end
    end
  end
end
