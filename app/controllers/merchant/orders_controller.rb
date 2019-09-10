class Merchant::OrdersController <Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @user = @order.user
  end
end
