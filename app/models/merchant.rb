class Merchant <ApplicationRecord
  has_many :items
  has_many :item_orders, through: :items
  has_many :users
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip


  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    orders
      .joins("inner join users on orders.user_id = users.id")
      .where(status: :shipped)
      .distinct
      .pluck(:city)
  end


  def item_orders_from_merchant(order_id)
    item_orders.where(order_id: order_id)
  end

end
