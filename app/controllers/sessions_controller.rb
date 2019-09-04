class SessionsController <ApplicationController

  def new
    if current_user
      flash[:success] = "You are already logged in."
      redirect_user(current_user)
    end
  end

  def logout
    # need to remove forget user
    redirect_to root_path
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_user(user)
    else
      flash[:error] = "Sorry, we don't recognize that email and password"
      redirect_to '/login'
    end
  end

  private
  def redirect_user(user)
    if user.default?
      redirect_to '/profile'
    elsif user.merchant?
      redirect_to '/merchant'
    elsif user.admin?
      redirect_to '/admin'
    end
  end
end
