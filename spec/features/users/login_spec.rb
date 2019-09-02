require 'rails_helper'

RSpec.describe "Logging In" do
  context "as a regular user" do
    it "can login with valid information" do
      user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button "Log In"

      expect(page).to have_content("Welcome, #{user.name}!")
      expect(current_path).to eq("/profile")
    end

    it 'redirects and flashes if already logged in' do
      user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/login'
      expect(page).to have_content("You are already logged in.")
      expect(current_path).to eq('/profile')
    end
  end

  context "as a merchant employee" do
    it "can login with valid information" do
      user = User.create(role: 1, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button "Log In"

      expect(page).to have_content("Welcome, #{user.name}!")
      expect(current_path).to eq("/merchant")
    end

    it 'redirects and flashes if already logged in' do
      user = User.create(role: 1, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/login'
      expect(page).to have_content("You are already logged in.")
      expect(current_path).to eq('/merchant')
    end
  end

  context "as a merchant admin" do
    it "can login with valid information" do
      user = User.create(role: 2, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button "Log In"

      expect(page).to have_content("Welcome, #{user.name}!")
      expect(current_path).to eq("/merchant")
    end

    it 'redirects and flashes if already logged in' do
      user = User.create(role: 2, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/login'
      expect(page).to have_content("You are already logged in.")
      expect(current_path).to eq('/merchant')
    end
  end

  context "as an admin" do
    it "can login with valid information" do
      user = User.create(role: 3, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button "Log In"

      expect(page).to have_content("Welcome, #{user.name}!")
      expect(current_path).to eq("/admin")
    end

    it 'redirects and flashes if already logged in' do
      user = User.create(role: 3, name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/login'
      expect(page).to have_content("You are already logged in.")
      expect(current_path).to eq('/admin')
    end
  end

  it 'keeps users logged in' do
    user = User.create(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210, email: 'brian@hotmail.com', password: '123abc')

    visit '/login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Log In"

    visit '/profile'
    expect(page).to have_content(user.name)
  end
end
