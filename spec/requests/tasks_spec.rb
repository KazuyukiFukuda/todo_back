require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "POST /task" do
    context "success" do
      before do
        user = FactoryBot.create(:user)
        sign_in_as(user.email, user.password)
        @task_hash = {
          name: "部屋掃除",
          description: "窓拭きを含めた基本的な掃除を行う",
          deadline: "YYYY-MM-DD",
          assignee_email: "kazu@test.com",
          public: false,
          subtasks: [
            {"description": "部屋の床拭きを行う"}
          ]
        }
      end

      it "post successfuly" do
        post tasks_path, :params => @task_hash.to_json, headers: {"Content-Type" => "application/json"}
        expect(response).to have_http_status(200)
      end

      it "is saved db" do
        expect{
          post tasks_path, :params => @task_hash.to_json, headers: {"Content-Type" => "application/json"}
        }.to change(Task, :count).by(1)
      end
    end
    
  end
  

  describe "GET /tasks" do
    @task = FactoryBot.create(:task)

    context "success" do
      it "returns 200 status" do
        get tasks_path
        expect(response).to have_http_status(200)
      end

      it "returns all task" do
        expect(JSON.load(response.body).length).to eq(Task.count)
      end

      it "has good properties" do
        a_hash = JSON.load(response.body)[0]
        answer_task = Task.find_by(id: a_hash["id"])
        
      end
    end
    
  end
end
