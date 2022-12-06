class ApplicationController < ActionController::Base
    private
    def is_login?
        return session[:logged_in] == true
    end

    def get_login_user
        return User.where(id: session[:login_user_id].to_i ).first
    end

    def must_be_logged_in
        if is_login?
            return true
        else
            redirect_to login_path, notice: 'you must be login first'
            return false
        end
    end

    def must_be_admin
        if(must_be_logged_in)
            @user = get_login_user
            if(@user.user_type == 0)
                return true
            else
                redirect_to main_path, notice: 'you must be admin to access this page'
            end
        end
    end

    def must_be_seller_or_admin
        if(must_be_logged_in)
            @user = get_login_user
            if(@user.user_type == 1 || @user.user_type == 0)
                return true
            else
                redirect_to main_path, notice: 'you must be seller or admin to access this page'
            end
        end
    end

    def must_be_buyer_or_admin
        if(must_be_logged_in)
            @user = get_login_user
            if(@user.user_type == 2 || @user.user_type == 0)
                return true
            else
                redirect_to main_path, notice: 'you must be buyer or admin to access this page'
            end
        end
    end
end