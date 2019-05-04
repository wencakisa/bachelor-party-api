class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[destroy]
  load_and_authorize_resource

  def index
    @users = User.all
    @users = User.by_role(role) if role

    json_response @users
  end

  def create
    @user = User.new(user_params)

    if @user.save
      json_response @user, :created
    else
      error_response @user
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def role
    params[:role]
  end

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(
      :id,
      :email,
      :password,
      :role
    )
  end
end
