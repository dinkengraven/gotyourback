class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to "/"
    else
      flash.now[:error] = "Your credentials did not match. Please try again."
      render "new"
    end
  end
end
