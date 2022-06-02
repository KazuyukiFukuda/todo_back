class UsersController < ApplicationController
    def create
        @user = User.new(params[:user])
        if @user.save

        else
            
        end
    end

    def index

    end

    def update

    end
end
