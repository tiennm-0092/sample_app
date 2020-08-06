class UsersController < ApplicationController
  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t ".success_mess"
      redirect_to user_path @user
    else
      flash.now[:danger] = t ".fail_mess_create"
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".fail_mess_notfound"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end
end
