class Admin::DashboardController <ApplicationController
  before_action :check_for_admin


  def index
  end

  def check_for_admin
    render file: 'public/404', status: 404 unless current_admin?
  end

end
