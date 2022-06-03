class ApplicationController < ActionController::API

    
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil?
    end

    # 現在のユーザーをログアウトする
    def log_out
        session[:user_id].clear
        @current_user = nil
    end

end
