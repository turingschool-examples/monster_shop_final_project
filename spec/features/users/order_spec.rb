# User Story 25, User Profile displays Orders link
#
# As a registered user
# When I visit my Profile page
# And I have orders placed in the system
# Then I see a link on my profile page called "My Orders"
# When I click this link my URI path is "/profile/orders"
require 'rails_helper'

RSpec.describe 'User Order Page As a User' do
  describe 'when I visit my profile page' do
    before(:each) do
      User.create(name: "mike", address: '123 dao ave', city: "Sparta", state: "NJ", zip: 30450, email: 'mdao@gmail.com', password: '123dao', password_confirmation: '123dao')
      @user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc', password_confirmation: '123abc')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I see a link that takes me to a page that shows all  my orders" do
      visit '/profile'

      click_on "My Orders"

      expect(current_path).to eq("/profile/orders")
    end


  end
end
