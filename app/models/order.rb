class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  enum status: ['pending', 'packaged', 'shipped', 'cancelled']

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def count_of_items
    item_orders.sum(:quantity)
  end
end
