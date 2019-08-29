class SessionsController <ApplicationController

  def new

  end

  def logout
    # need to remove forget user
    redirect_to root_path
  end
end
