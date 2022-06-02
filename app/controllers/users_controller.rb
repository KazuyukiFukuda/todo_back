class UsersController < ApplicationController
    def create
        json_request = JSON.parse(request.body.read)
        @user = User.new(json_request)
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            render json: {display_name: @user.display_name}, status: 201
        else
            render json: { message:"failed to signup"}, status: 400

        end
    end

    def index
        if logged_in?
            list = User.all
            all_users = []
            list.each do |v|
                all_users.push( {:id => v.id, email: v.email, display_name: v.display_name} )
            end
            render json: all_users, status: 200
        else
           render json: {message: "loginされていません"}, status: 401
        end
    end

    def update
        if logged_in?
            @user = User.find(params[:id])
            json_request = JSON.parse(request.body.read)
            @user.update(json_request)
            render json: {message: json_request}, status: 200
        else
            render json: {message: "loginされていません"}, status: 401
        end

    end
end
