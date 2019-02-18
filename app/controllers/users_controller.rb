class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[destroy]
    load_and_authorize_resource
    
    def index
        @users = User.by_role('admin') + User.by_role('guide')
        json_response @users
    end

    def create
        @user = User.create!(user_params)
        json_response @user
    end

    def destroy
        @user.destroy
        head :no_content
    end

    private

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
