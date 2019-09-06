# I see all information about the order, including the following information:
# - the ID of the order
# - the date the order was made
# - the date the order was last updated
# - the current status of the order
# - each item I ordered, including name, description, thumbnail, quantity, price and subtotal
# - the total quantity of items in the whole order
# - the grand total of all items for that order
require 'rails_helper'

RSpec.describe 'User Order Page As a User' do
  describe 'when I visit an orders show page from my profile' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      @user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc', password_confirmation: '123abc')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @order_1 = @user.orders.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      @order_2 = @user.orders.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204)

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
      @order_2.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 2)
      @order_2.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 2)
      @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
    end

    it "the uri looks like /profile/orders/:id" do
      visit '/profile/orders'

      within "#user-orders-#{@order_1.id}" do
        click_link @order_1.id
      end

      expect(current_path).to eq("/profile/orders/#{@order_1.id}")
    end

    it "the order show page has order and item info" do
      visit "/profile/orders/#{@order_1.id}"

      within "#user-orders-#{@order_1.id}" do
        expect(page).to have_content(@order_1.id)
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_content(@order_1.updated_at)
        expect(page).to have_content(@order_1.status)
      end

      within "#item-#{@tire.id}" do
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_content(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("2")
        expect(page).to have_content("$100")
        expect(page).to have_content("$200")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
        expect(page).to have_content(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("3")
        expect(page).to have_content("$10")
        expect(page).to have_content("$30")
      end

      expect(page).to have_content("Number of Items: 5")
      expect(page).to have_content("Total: $230.00")
    end
  end
end
