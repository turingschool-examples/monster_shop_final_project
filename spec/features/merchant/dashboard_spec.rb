require 'rails_helper'

RSpec.describe 'merchant dashboard page', type: :feature do
  describe 'As a merchant' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)

      @merch_employee = @bike_shop.users.create(name: 'Brian', address: '123 Brian St', city: 'Denver', state: 'CO', zip: 80218, email: 'brian@example.com', password: 'securepassword', role: 1)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @shifter = @bike_shop.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)

      @order_1 = @merch_employee.orders.create!(status: "pending")
      @order_2 = @merch_employee.orders.create!(status: "pending")
      @order_3 = @merch_employee.orders.create!(status: "pending")
      @order_item_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: 0)
      @order_item_2 = @order_2.item_orders.create!(item: @chain, price: @chain.price, quantity: 2, status: 1)
      @order_item_3 = @order_2.item_orders.create!(item: @shifter, price: @shifter.price, quantity: 2, status: 0)
      @order_item_4 = @order_3.item_orders.create!(item: @shifter, price: @shifter.price, quantity: 2, status: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merch_employee)
    end
    it "when I visit my dashboard theres a link to view my own items" do
      visit '/merchant'
      
      click_link "View Items"

      expect(current_path).to eq("/merchant/items")
    end
  end
end
# As a merchant employee or admin
# When I visit my merchant dashboard
# I see a link to view my own items
# When I click that link
# I should be taken to my merchant's items ("/merchant/items")
