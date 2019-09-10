class Order <ApplicationRecord
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

  def change_item_order_status
    item_orders.each do |item_order|
      item_order.update(status: 0)
    end
  end

end
