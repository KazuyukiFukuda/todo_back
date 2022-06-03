class TasksController < ApplicationController
    def create
        if logged_in?
            json_request = JSON.parse(request.body.read)
            #assignee_email = json_request["assignee_email"]
            #@assignee_user = User.find_by(email: assignee_email)
            @user =  current_user

            #reject
            task_hash_rejected = json_request.reject {|key| key=="assignee_email"}
            #add
            #task_hash = task_hash_rejected.store("assignee_id", @assignee_user.id)

            params = {tasks:{
                tasks_attributes: [task_hash_rejected]
            }}

            @user.attributes = params[:tasks]
            @user.tasks.save

            render json: {message: params}, status:200
        else
            render json: {message: "loginされていません"}, status: 400
        end
    end
end
