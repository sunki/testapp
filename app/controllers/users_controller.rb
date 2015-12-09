class UsersController < ApplicationController

  skip_before_filter :require_logged_in_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].permit(:email, :password, :password_confirmation))

    if @user.save
      UserSession.create(@user)
      redirect_to(root_path)
    else
      render(action: :new)
    end
  end
end
