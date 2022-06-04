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
end
