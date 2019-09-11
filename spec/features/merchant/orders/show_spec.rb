require 'rails_helper'


RSpec.describe 'As a merchant' do
  describe 'When I visit an order show page from my dashboard' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @user = @bike_shop.users.create(name: 'Brian', address: '123 Zanti St.', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc', password_confirmation: '123abc', role: 1)

      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @shifter = @bike_shop.items.create(name: "Shimano Shifters", description: "It'll always shift!", price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 10)

      @order_1 = @user.orders.create!(status: "pending")

      @order_item_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: 0)
      @order_item_1 = @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 2, status: 0)
      @order_item_2 = @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 4, status: 0)
      @order_item_3 = @order_1.item_orders.create!(item: @shifter, price: @shifter.price, quantity: 6, status: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I see the customers name and address" do
      visit merchant_order_path(@order_1)

      expect(page).to have_content("Brian")
      expect(page).to have_content("123 Zanti St.")
      expect(page).to have_content("Denver, CO 80210")
    end

    it "only shows items that are being purchased from my merchant" do
      visit merchant_order_path(@order_1)

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_content("$100.00")
        expect(page).to have_content("2")
      end
      within "#item-#{@chain.id}" do
        expect(page).to have_link(@chain.name)
        expect(page).to have_css("img[src*='#{@chain.image}']")
        expect(page).to have_content("$50.00")
        expect(page).to have_content("4")
      end
      within "#item-#{@shifter.id}" do
        expect(page).to have_link(@shifter.name)
        expect(page).to have_css("img[src*='#{@shifter.image}']")
        expect(page).to have_content("$180.00")
        expect(page).to have_content("6")
      end

      expect(page).to_not have_link(@pull_toy.name)
      expect(page).to_not have_css("#item-#{@pull_toy.id}")
    end
  end
end

# I only see the items in the order that are being purchased from my merchant
# I do not see any items in the order being purchased from other merchants
# For each item, I see the following information:
# - the name of the item, which is a link to my item's show page
# - an image of the item
# - my price for the item
# - the quantity the user wants to purchase
