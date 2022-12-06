class ApplicationController < ActionController::Base
    private
    def is_login?
        return session[:logged_in] == true
    end

    def must_be_logged_in
        if is_login?
            return true
        else
            redirect_to main_login_path, notice: 'you must be login first'
        end
    end
    
    def is_admin
        if(session[:logged_in])
            @user_login_id = User.where(id:  session[:login_user_id].to_i ).first
            if(@user_login_id.user_type == 0)
                return true
            else
                return false
            end
        else 
            return false
        end
    end

    def is_seller
        if(session[:logged_in])
            @user_login_id = User.where(id:  session[:login_user_id].to_i ).first
            if(@user_login_id.user_type == 1)
                return true
            else
                return false
            end
        else 
            return false
        end
    end

    def is_buyer
        if(session[:logged_in])
            @user_login_id = User.where(id:  session[:login_user_id].to_i ).first
            if(@user_login_id.user_type == 2)
                return true
            else
                return false
            end
        else 
            return false
        end
    end
end
