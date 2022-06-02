class UsersController < ApplicationController
    def create
        json_request = JSON.parse(request.body.read)
        @user = User.new(json_request)
        if @user.valid?
            @user.save
            session[:session_id] = @user.id
            render json: {display_name: @user.display_name}, status: 201
        else
            render json: { message:"failed to signup"}, status: 400

        end
    end

    def index

    end

    def update

    end
end
