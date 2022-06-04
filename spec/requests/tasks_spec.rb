require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "POST /task" do
    before do
      @user = FactoryBot.create(:user)
      @assignee_user = FactoryBot.create(:user)
      sign_in_as(@user.email, @user.password)
      @params = {
        name: "部屋掃除",
        description: "窓拭きを含めた基本的な掃除を行う",
        deadline: "2022-07-00",
        assignee_email: @assignee_user.email,
        public: false,
        subtasks: [
          {description: "部屋の床拭きを行う"}
        ]
      }
    end

    context "success" do
      it "post successfuly" do
        post tasks_path, :params => @params.to_json, headers: {"Content-Type" => "application/json"}
        expect(response).to have_http_status(200)
      end

      it "post successfuly withou assignee_email" do
        @params[:assignee_email] = nil
        post tasks_path, :params => @params.to_json, headers: {"Content-Type" => "application/json"}
        expect(response).to have_http_status(200)
      end

      it "posts successfuly without subtask" do
        @params[:subtasks] = nil
        post tasks_path, :params => @params.to_json, headers: {"Content-Type" => "application/json"}
      end

      it "saves task in db" do
        expect{
          post tasks_path, :params => @params.to_json, headers: {"Content-Type" => "application/json"}
        }.to change(@user.owned_tasks, :count).by(1)
      end

      it "saves subtasks in db" do
        expect{
          post tasks_path, :params => @params.to_json, headers: {"Content-Type" => "application/json"}
        }.to change(Subtask, :count).by(@params[:subtasks].length)
      end
    end

    context "failed" do
      it "returns error if assignee user is not exist" do
        @params[:assignee_email] = Faker::Internet.email
        post tasks_path, :params => @params.to_json, headers: {"Content-Type" => "application/json"}
        expect(response.body).to include("emailに該当するユーザーが存在しません")
      end
    end
  end

  
  describe "GET /tasks" do
    context "success" do
      user = FactoryBot.create(:user_with_tasks)

      before(:each) do
        sign_in_as(user.email, user.password)
        get tasks_path
      end

      it "returns 200 status" do
        expect(response).to have_http_status(200)
        #expect(JSON.parse(response.body)["message"]).to eq(user.id)
      end

      it "returns all task" do
        hoge = JSON.parse(response.body)["message"]

        expect(hoge.length).to eq(user.owned_tasks.count + user.assigned_tasks.count)
      end

      it "returns correct params" do
        returned_params = JSON.parse(response.body)["message"][0].keys
        correct_params = [
          "name",
          "public",
          "completed",
          "deadline",
          "task_id",
          "create_user",
          "assignee_user",
          "total_subtask_amount",
          "finished_subtask_amount",
        ]
        expect(returned_params - correct_params).to eq []
      end
    end
    context "failed " do
      it "failed without login" do
        get tasks_path
        expect(response).to have_http_status(401)
      end
    end
    
  end

  describe "GET /task/:id"
    user = FactoryBot.create(:user_with_tasks_subtask)
    task = user.owned_tasks[0]

    context "success" do
      before(:each) do
        sign_in_as(user.email, user.password)
        get task_path(task.id)
      end

      it "returns 200 status" do
        expect(response).to have_http_status(200)
      end

      it "returns the correct subtasks" do
        returned_subtasks = JSON.parse(response.body)["message"]["subtasks"]
        correct_subtasks = task.subtasks

        duplicate_subtasks = returned_subtasks & correct_subtasks
        expect(duplicate_subtasks.length).to eq(correct_subtasks.length)

      end

      it "returns correct params" do
        returned_params = JSON.parse(response.body)["message"][0].without("subtasks")
        correct_params = task.attributes.without(:id, :completed, :user_id, :created_at, :updated_at)
        expect(returned_params).to eq(correct_params)
      end
    end

    context "failed" do
      it "failed withou without login" do
        get task_path(task.id)
        expect(response).to have_http_status(401)
      end

      it "returns 404 status when getting task that doesn't exist" do
        sign_in_as(user.email, user.password)
        get task_path(Task.count+1)
        expect(response).to have_http_status(404)
      end
    end
    
    
end
