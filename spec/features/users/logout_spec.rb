require 'rails_helper'

RSpec.describe "Logout" do
  it "logs a user out" do
    user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

    visit '/login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Log In"

    click_link "Logout"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You are now logged out.")

    visit profile_path
    expect(page.status_code).to eq(404)
  end

  it "removes all items from the cart" do
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

    visit '/login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Log In"

    visit "/items/#{paper.id}"
    click_on "Add To Cart"

    click_link "Logout"

    expect(page).to have_content("Cart: 0")
  end
end
