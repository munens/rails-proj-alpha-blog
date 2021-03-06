class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update]
    beofre_action :require_admin, only: [:destroy]

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
            # redirect to the users show page upon signing in:
            redirect_to user_path(@user)
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

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "User has been removed with all their articles"
        redirect_to users_path
    end

    private

        def user_params
            params.require(:user).permit(:username, :email, :password)
        end

        def set_user
            @user = User.find(params[:id])
        end

        def require_same_user
			if current_user != @user and !current_user.admin?
				flash[:danger] = "You can only edit or delete your own articles"
				redirect_to root_path
			end
		end

        def require_admin
            if logged_in? and !current_user.admin?
                flash[:danger] = "Only admin users can perform that action"
                redirect_to root_path
            end
        end
end