class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]

    def new
        @user = User.new
    end

    def index 
        # @users = User.all
        # add pagination to all users:
        @users = User.paginate(page: params[:page], per_page: 3)
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to the african presidents blog #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def show
        # due to before_action:  @user = User.find(params[:id])

        # we want to add pagination to user articles here:
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end

    def edit
        # due to before_action: @user = User.find(params[:id])
    end

    def update
        # due to before_action:  @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Your account was updated successfully"
            redirect_to articles_path
        else
            render 'edit'
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end
end