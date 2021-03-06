class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      @errors = @user.errors.full_messages
      render "new"
    end
  end

  def show
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :location, :username, :email, :password)
    end
end
