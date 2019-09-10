class User::OrdersController <ApplicationController

  def index
    @orders = current_user.orders
  end

  def show
    # binding.pry
    @order = Order.find(params[:id])
  end

  def cancel
    order = Order.find(params[:id])
    order.update!(status: 3)
    order.change_item_order_status
    flash[:success] = "The order has been cancelled"
    redirect_to "/profile/orders/#{order.id}"
  end
end
