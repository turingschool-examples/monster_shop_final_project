require 'rails_helper'


RSpec.describe 'As a merchant' do
  describe 'When I visit an order show page from my dashboard' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(name: 'Brian', address: '123 Zanti St.', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc', password_confirmation: '123abc')

      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @shifter = @bike_shop.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)

      @order_1 = @user.orders.create!(status: "pending")

      @order_item_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: 0)
      @order_item_2 = @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 2, status: 0)
      @order_item_3 = @order_1.item_orders.create!(item: @shifter, price: @shifter.price, quantity: 2, status: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I see the customers name and address" do
      visit merchant_order_path(@order_1)

      expect(page).to have_content("Brian")
      expect(page).to have_content("123 Zanti St.")
      expect(page).to have_content("Denver, CO 80210")
    end
  end
end

# I see the customer's name and address
# I only see the items in the order that are being purchased from my merchant
# I do not see any items in the order being purchased from other merchants
# For each item, I see the following information:
# - the name of the item, which is a link to my item's show page
# - an image of the item
# - my price for the item
# - the quantity the user wants to purchase
