class UsersController < ApplicationController
    def create
        json_request = JSON.parse(request.body.read)
        user = User.new(json_request)
        if user.valid?
            user.save
            session[:user_id] = user.id
            render json: {display_name: user.display_name}, status: 201
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
            current_user
            user_id = params[:id].to_i
            json_request = JSON.parse(request.body.read)

            if !(User.where(id: user_id).exists?)
                render json: {message: "このユーザーは存在しません"}, status: 404
                return
            else
                user = User.find(user_id)
            end

            if current_user != User.find(user_id)
                render json: {message: "このユーザーへのアクセス権限がありません"}, status: 401
                return
            end

            if BCrypt::Password.new(user.password_digest) != json_request["current_password"]
                render json: {message: "パスワードが間違っています"}, status:400
                return
            end

            if json_request["password"] != json_request["password_confirmation"]
                render json: {message: "新たなパスワードと確認用パスワードが異なっています"}, status:400
                return
            end

            if json_request["password"].nil?
                json_request["password"] = json_request["current_password"]
            end


            updated_user_hash = json_request.without("current_password")
            
            updated_user_hash.delete_if{ |_, v| v == nil }
            hoge = updated_user_hash.symbolize_keys

            hoge = user.update!(updated_user_hash)

            render json: {message: hoge}, status: 200
        else
            render json: {message: "loginされていません"}, status: 401
        end

    end
end
