class Merchant::OrdersController <Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @user = @order.user
    @merchant = Merchant.find(@user.merchant_id)
  end
end
