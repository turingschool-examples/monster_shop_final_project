require 'rails_helper'

RSpec.describe 'User Order Page As a User' do
  describe 'when I visit my profile page' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      @user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc', password_confirmation: '123abc')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @order_1 = @user.orders.create!
      @order_2 = @user.orders.create!

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
      @order_2.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 2)
      @order_2.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 2)
      @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
    end

    it "I see a link that takes me to a page that shows all  my orders" do
      visit '/profile'

      click_on "My Orders"

      expect(current_path).to eq("/profile/orders")
    end

    it "On the order page I can see every order I've made " do
      visit '/profile/orders'

      within "#user-orders-#{@order_1.id}" do
        expect(page).to have_link(@order_1.id)
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_content(@order_1.updated_at)
        expect(page).to have_content("pending")
        expect(page).to have_content("5")
        expect(page).to have_content("230.0")
      end

      within "#user-orders-#{@order_2.id}" do
        expect(page).to have_link(@order_2.id)
        expect(page).to have_content(@order_2.created_at)
        expect(page).to have_content(@order_2.updated_at)
        expect(page).to have_content("pending")
        expect(page).to have_content("6")
        expect(page).to have_content("260.0")
      end

      within "#user-orders-#{@order_1.id}" do
        click_link @order_1.id
      end

      expect(current_path).to eq("/profile/orders/#{@order_1.id}")

    end

  end
end
