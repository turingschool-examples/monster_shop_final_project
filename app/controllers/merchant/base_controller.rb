class Merchant::BaseController < ApplicationController
  before_action :check_for_merchant


  private

  def check_for_merchant
    render file: 'public/404', status: 404 unless current_user_merchant?
  end
end
