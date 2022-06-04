class TasksController < ApplicationController
    def create
        if logged_in?
            json_request = JSON.parse(request.body.read)
            @user =  current_user

            assignee_email = json_request["assignee_email"]
            subtasks = json_request["subtasks"]
            subtasks.each do |a_subtask|
                a_subtask.store("completed", false)
            end
            task_hash = json_request.without("assignee_email", "subtasks")
            task_hash.store("completed", false)
            assignee_user = User.find_by(email: assignee_email)

            if assignee_user.nil? && !assignee_email.nil?
                render json: {message: "emailに該当するユーザーが存在しません"}, status:(400)
            else
                task_hash.store("assignee_id", assignee_user.id) if !assignee_user.nil?
                tasks = @user.owned_tasks.create(task_hash)
                tasks.subtasks.create(subtasks)
                render json: {message: "created the task successfully"}, status:200
            end
        else
            render json: {message: "loginされていません"}, status: 400
        end
    end
end
