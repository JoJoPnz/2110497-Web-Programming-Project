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
end
