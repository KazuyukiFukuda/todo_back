class TasksController < ApplicationController
    def create
        if logged_in?
            json_request = JSON.parse(request.body.read)
            @user =  current_user

            assignee_email = json_request["assignee_email"]
            subtasks = json_request["subtasks"]
            if !subtasks.nil?
                subtasks.each do |a_subtask|
                    a_subtask.store("completed", false)
                end
            end

            task_hash = json_request.without("assignee_email", "subtasks")
            task_hash.store("completed", false)
            assignee_user = User.find_by(email: assignee_email)

            if assignee_user.nil? && !assignee_email.nil?
                render json: {message: "emailに該当するユーザーが存在しません"}, status:(400)
            else
                task_hash.store("assignee_id", assignee_user.id) if !assignee_user.nil?
                tasks = @user.owned_tasks.create(task_hash)
                tasks.subtasks.create(subtasks) if !subtasks.nil?
                render json: {message: "created the task successfully"}, status:200
            end
        else
            render json: {message: "loginされていません"}, status: 400
        end
    end

    def index
        if logged_in?
            user =  current_user
            user_task = user.owned_tasks.select(:id, :name, :user_id, :assignee_id, :public, :completed, :deadline)
            user_task += user.assigned_tasks.select(:id, :name, :user_id, :assignee_id, :public, :completed, :deadline)
            return_list = []

            user_task.each do |a_task|
                #getting information
                a_task_hash = a_task.attributes

                create_user_name = User.find(a_task_hash["user_id"]).display_name
                if !a_task_hash["assignee_id"].nil?
                    assignee_user_model = User.find(a_task_hash["assignee_id"])
                    assignee_user_name = assignee_user_model.nil? ? "" : assignee_user_model.display_name
                else
                    assignee_user_name = ""
                end

                adding_hash = {
                    task_id: a_task_hash["id"],
                    create_user: create_user_name,
                    assignee_user: assignee_user_name,
                    total_subtask_amount: a_task.subtasks.count,
                    finished_subtask_amount: a_task.subtasks.where(completed: true).count,
                }

                #delete params
                a_task_hash = a_task_hash.without("id", "user_id", "assignee_id")
                a_task_hash.merge!(adding_hash)

                return_list.push(a_task_hash)
            end

            render json: {message: return_list}, status: 200
        else
            render json: {message: "hoge"}, status: 401
        end
    end

    def show
        if logged_in?
            user = current_user
            task_id = params[:id]

            if Task.where(id: task_id).exists?
                task = Task.find(task_id)
            else
                render json: {message: "そのタスクは存在しません"}, status: 404
                return
            end

            if !(task.user_id == user.id || task.assignee_id == user.id)
                render json: {message: "このタスクへの閲覧権限がありません"}, status: 401
                return
            end

            task_hash = task.attributes
            return_hash = task_hash.without("id", "completed", "user_id", "created_at", "updated_at")

            return_subtasks = []
            subtasks = task.subtasks
            subtasks.each do |a_subtask|
                subtask_hash = a_subtask.attributes
                return_subtasks.push(subtask_hash.without("task_id", "created_at", "updated_at"))
            end

            return_hash.store("subtasks", return_subtasks)

            render json: {message: return_hash}, status: 200

        else
            render json: {message: "loginされていません"}, status: 401
        end
    end

    def update
        render json: {message: "hoge"}, status: 200
    end
end
