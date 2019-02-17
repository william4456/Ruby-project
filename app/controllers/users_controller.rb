class UsersController < ApplicationController
    before_action :load_user
    before_action :load_posts
    before_action :authenticate_user!, only: [:edit, :update]

    def new
        @user = User.new
    end

    def create 
        @user = User.create(get_params)
        if @user.valid?
            redirect_to posts_path
        else
            render 'new'
        end
    end

    def update
        @user = User.update(params[:id], get_params)
        if @user.valid?
            redirect_to user_path
        else
            render 'new'
        end
    end

    def destroy
    end

    def load_posts
        @posts = User.find(params[:id]).posts
    end

    def load_user
        @user = User.find(params[:id])
    end

    def not_found
        raise ActionController::RoutingError.new('Not Found')
    end

    def get_params
        user_params = params.require(:user).permit(:last_name, :first_name, :birth_date)
    end
end
