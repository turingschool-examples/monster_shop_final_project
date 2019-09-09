require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :items}
    it {should have_many :users}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    it "#distinct_cities" do
      merchant = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      item_1 = merchant.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      item_2 = merchant.items.create!(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      user_1 = User.create!(email: 'brian@hotmail.com', password: 'password', name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210)
      user_2 = User.create!(email: 'meg@hotmail.com', password: 'password', name: 'Meg', address: '123 Stang St', city: 'Kansas City', state: 'CO', zip: 80210)
      user_3 = User.create!(email: 'ian@hotmail.com', password: 'password', name: 'Ian', address: '123 Douglas St', city: 'Denver', state: 'CO', zip: 80210)
      user_4 = User.create!(email: 'sal@hotmail.com', password: 'password', name: 'Sal', address: '123 Espinosa St', city: 'Vail', state: 'CO', zip: 80210)
      user_5 = User.create!(email: 'sal1@hotmail.com', password: 'password', name: 'Sal', address: '123 Espinosa St', city: 'Washington D.C.', state: 'CO', zip: 80210)
      user_6 = User.create!(email: 'sal2@hotmail.com', password: 'password', name: 'Sal', address: '123 Espinosa St', city: 'Hershey', state: 'CO', zip: 80210)
      user_7 = User.create!(email: 'sal3@hotmail.com', password: 'password', name: 'Sal', address: '123 Espinosa St', city: 'Hershey', state: 'CO', zip: 80210)

      invalid_order_1 = Order.create!(status: "pending", user: user_1)
      invalid_order_2 = Order.create!(status: "packaged", user: user_2)
      invalid_order_3 = Order.create!(status: "cancelled", user: user_3)
      order_1 = Order.create!(status: "shipped", user: user_4)
      order_2 = Order.create!(status: "shipped", user: user_4)
      order_3 = Order.create!(status: "shipped", user: user_5)
      order_4 = Order.create!(status: "shipped", user: user_6)
      order_5 = Order.create!(status: "shipped", user: user_7)

      invalid_order_1.item_orders.create!(item: item_1, price: 2, quantity: 1)
      invalid_order_2.item_orders.create!(item: item_1, price: 2, quantity: 1)
      invalid_order_3.item_orders.create!(item: item_1, price: 2, quantity: 1)
      order_1.item_orders.create!(item: item_1, price: 2, quantity: 1)
      order_2.item_orders.create!(item: item_1, price: 2, quantity: 1)
      order_3.item_orders.create!(item: item_2, price: 2, quantity: 1)
      order_4.item_orders.create!(item: item_2, price: 2, quantity: 1)
      order_5.item_orders.create!(item: item_2, price: 2, quantity: 1)

      expected = ['Hershey', 'Vail', 'Washington D.C.']
      expect(merchant.distinct_cities.sort).to eq(expected)
    end
  end
end
