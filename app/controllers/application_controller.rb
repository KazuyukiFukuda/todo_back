class ApplicationController < ActionController::API

    
    def log_in(user)
        session[:session_id] = user.id
    end

    def logged_in?
        session[:session_id] != nil
    end

    # 現在のユーザーをログアウトする
    def log_out
        session[:session_id].clear
        @current_user = nil
    end

end
