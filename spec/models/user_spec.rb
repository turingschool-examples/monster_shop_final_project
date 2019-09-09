require 'rails_helper'

describe User, type: :model do

  describe "relationships" do
    it {should belong_to(:merchant).optional}
    it {should have_many(:orders)}
  end

  describe "roles" do
    it "is a regular user by default" do
      user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')
      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it "can be a merchant employee" do
      user = User.create(role: 1, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')
      expect(user.role).to eq('merchant_employee')
      expect(user.merchant_employee?).to be_truthy
    end

    it "can be a merchant admin" do
      user = User.create(role: 2, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')
      expect(user.role).to eq('merchant_admin')
      expect(user.merchant_admin?).to be_truthy
    end

    it "can be an admin" do
      user = User.create(role: 3, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')
      expect(user.role).to eq('admin')
      expect(user.admin?).to be_truthy
    end

    it "can recognize either merchant role as a merchant" do
      user_1 = User.create(role: 1, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')
      expect(user_1.merchant?).to be_truthy

      user_2 = User.create(role: 2, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')
      expect(user_2.merchant?).to be_truthy

      user_3 = User.create(role: 3, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')
      expect(user_3.merchant?).to be_falsy
    end
  end
end
