class SessionsController < ApplicationController

    def new

    end

    def create 
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            
            #create the session hash based on the current users id.
            session[:user_id] = user.id

            flash[:success] = "You have successfully logged in"
            redirect_to user_path(user)
        else
            # create a message when a user's authentication fails to work. When rendering a new page as below, 
            # we use flash.now so the flash message doesnt appear on the current page and the new page we are Srendering.
            flash.now[:danger] = "There was something wrong with your login information"
            render 'new'
        end
    end

    def destroy
        # remove our session hash when user has logged out
        session[:user_id] = nil
        flash[:success] = "You have logged out"
        redirect_to root_path
    end
end

