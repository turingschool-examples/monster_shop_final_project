# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Item.destroy_all
Merchant.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

#default users
default_1 = User.create(email: 'brian@hotmail.com', password: 'password', name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210)
default_2 = User.create(email: 'meg@hotmail.com', password: 'password', name: 'Meg', address: '123 Stang St', city: 'Denver', state: 'CO', zip: 80210)
default_3 = User.create(email: 'ian@hotmail.com', password: 'password', name: 'Ian', address: '123 Douglas St', city: 'Denver', state: 'CO', zip: 80210)
default_4 = User.create(email: 'sal@hotmail.com', password: 'password', name: 'Sal', address: '123 Espinosa St', city: 'Denver', state: 'CO', zip: 80210)

#merchant employees
merchant_employee_1 = User.create(role: 1, email: 'brian_me@hotmail.com', password: 'password', name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210)
merchant_employee_2 = User.create(role: 1, email: 'meg_me@hotmail.com', password: 'password', name: 'Meg', address: '123 Stang St', city: 'Denver', state: 'CO', zip: 80210)
merchant_employee_3 = User.create(role: 1, email: 'ian_me@hotmail.com', password: 'password', name: 'Ian', address: '123 Douglas St', city: 'Denver', state: 'CO', zip: 80210)
merchant_employee_4 = User.create(role: 1, email: 'sal_me@hotmail.com', password: 'password', name: 'Sal', address: '123 Espinosa St', city: 'Denver', state: 'CO', zip: 80210)

#merchant admins
merchant_admin_1 = User.create(role: 2, email: 'brian_ma@hotmail.com', password: 'password', name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210)
merchant_admin_2 = User.create(role: 2, email: 'meg_ma@hotmail.com', password: 'password', name: 'Meg', address: '123 Stang St', city: 'Denver', state: 'CO', zip: 80210)
merchant_admin_3 = User.create(role: 2, email: 'ian_ma@hotmail.com', password: 'password', name: 'Ian', address: '123 Douglas St', city: 'Denver', state: 'CO', zip: 80210)
merchant_admin_4 = User.create(role: 2, email: 'sal_ma@hotmail.com', password: 'password', name: 'Sal', address: '123 Espinosa St', city: 'Denver', state: 'CO', zip: 80210)

#admins
admin_1 = User.create(role: 3, email: 'brian_a@hotmail.com', password: 'password', name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80210)
admin_2 = User.create(role: 3, email: 'meg_a@hotmail.com', password: 'password', name: 'Meg', address: '123 Stang St', city: 'Denver', state: 'CO', zip: 80210)
admin_3 = User.create(role: 3, email: 'ian_a@hotmail.com', password: 'password', name: 'Ian', address: '123 Douglas St', city: 'Denver', state: 'CO', zip: 80210)
admin_4 = User.create(role: 3, email: 'sal_a@hotmail.com', password: 'password', name: 'Sal', address: '123 Espinosa St', city: 'Denver', state: 'CO', zip: 80210)
