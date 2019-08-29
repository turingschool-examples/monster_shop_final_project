class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart,
                :current_user,
                :current_user_merchant

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user

  end

  def current_user_merchant
      # current_user.merchant_id
  end

end
