class MainController < ApplicationController
    before_action :must_be_logged_in, only: %i[ destroy profile edit_password menu ]
    def login
        if is_login?
            redirect_to main_path, alert: 'You have already logged in (Please logout to change account)'
        end
    end

    def create
        u = User.where(email: params[:email]).first
        if u && u.authenticate(params[:password])
    
          redirect_to main_path
    
          session[:logged_in] = true
          session[:login_user_id] = u.id
        else 
          redirect_to login_path, error: 'wrong username or password'
        end
    end
    
    def destroy
        reset_session
        redirect_to login_path, notice:"You have been logged out "
    end

    def profile 
        @user = User.where(id: params[:id].to_i).first
        if(session[:logged_in])
            @user_login_id = User.where(id:  session[:login_user_id].to_i ).first
        end
    end 

    def edit_password
        if(session[:logged_in])
            @user_login_id = User.where(id:  session[:login_user_id].to_i ).first
        end

        @new_password = params[:new_password]
        @confirm_password = params[:confirm_password]
        if(!@new_password.blank? && @new_password == @confirm_password) 
            @user_login_id.password = @new_password
            @user_login_id.save
            redirect_to profile_path, success: 'password has been changed'
        elsif(@new_password.blank? && !@new_password.nil?)
            redirect_to edit_password_path, error: 'password cannot be empty'
        elsif(@new_password != @confirm_password)
            redirect_to edit_password_path, error: 'password and confirm password are not match'
        end
    end
    
    def menu
    end
end
