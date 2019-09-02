class UsersController <ApplicationController
  before_action :check_for_user, only: :show
  def new
    @user = User.new
  end


  def show

  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "#{@user.name}, you are now registered and logged in."
      redirect_to profile_path
    elsif email_exists?(@user)
      flash[:error] = "There is already a user that exists with this email."
      render :new
    else
      flash[:error] = "Please fill in all fields in order to register"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def check_for_user
    render file: 'public/404', status: 404 unless current_user?
  end

  def email_exists?(user)
    if user.errors.full_messages.include?("Email has already been taken")
      @user.email = ""
      @user.password = ""
      @user.password_confirmation = ""
      return true
    end
  end
end
