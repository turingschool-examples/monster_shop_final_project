class UsersController <ApplicationController
  before_action :check_for_user, only: :show
  def new
    @user = User.new
  end


  def show

  end

  private

  def check_for_user
    render file: 'public/404', status: 404 unless current_user?
  end
end
