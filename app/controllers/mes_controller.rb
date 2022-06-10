class MesController < ApplicationController
    def index
        if logged_in?
            user = current_user
            render json: {id: user.id, display_name: user.display_name, email: user.email}, status: 201
        else
            render json: {message: "loginされていません"}, status: 401
        end
    end
end

