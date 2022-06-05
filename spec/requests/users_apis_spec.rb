require 'rails_helper'

RSpec.describe "UsersApis", type: :request do

  describe "POST /users" do
    context "successful" do
      user = FactoryBot.build(:user)

      it "returns sucsess with display name and email, password, password_confirmation" do
        sign_up(user)
        expect(response).to have_http_status(201)
        expect(response.body).to include(user.display_name)
        expect(session[:user_id]).to_not eq(nil)
      end

      it "creates user record in db" do
        expect{
          sign_up(user)
        }.to change(User, :count).by(1)
      end
    end

    context "failed" do
      user = FactoryBot.build(:user, password: nil)

      it "retursn fail" do
        sign_up(user)
        expect(response.body).to include("fail")
        expect(response).to have_http_status(400)
      end

      it "doesn't create user record in db" do
        expect{
          sign_up(user)
        }.to_not change(User, :count)
      end
    end
  end

  describe "GET /users" do
    user = FactoryBot.create(:user)

    context "sucess" do
      before do
        sign_in_as(user.email, user.password)
        get users_path
      end

      it "returns 200 status" do
        expect(response).to have_http_status(200)
      end

      it "returns all user list" do
        expect(JSON.load(response.body).length).to eq(User.count)
      end

      it "has id and email, display name for each" do
        a_hash = JSON.load(response.body)[0]
        answer_user = User.find_by(id: a_hash["id"])
        answer_hash = {"id"=> answer_user.id, "email"=> answer_user.email, "display_name"=> answer_user.display_name}
        expect(a_hash).to eq(answer_hash)
      end
    end

    context "fail" do
      it "can't get without login" do
        get users_path
        expect(response).to have_http_status(401)
      end
    end
  end


  describe "PATCH /users:id" do
    context "success" do
      let(:user) {FactoryBot.create(:user)}
      let(:update_email) {{
        display_name: nil,
        email: Faker::Internet.email,
        old_password: nil,
        password: nil,
        password_confirmation: nil,
      }}
      let(:update_password) {{
        display_name: nil,
        email: nil,
        old_password: user.password,
        password: "AAAbbb111",
        password_confirmation: "AAAbbb111",
      }}

      before do
        sign_in_as(user.email, user.password)
      end

      it "update successfully" do
        patch user_path(user.id), :params =>update_email.to_json, headers: {"Content-Type" => "application/json"}
        expect(user.attributes["email"]).to eq(update_email[:email])
      end

      it "doesn't update others" do
        expect{
          patch user_path(user.id), :params =>update_email.to_json, headers: {"Content-Type" => "application/json"}
        }.to change{ user.attributes.without["email"] }
      end

      it "update password successfully" do
        patch user_path(user.id), :params =>update_password.to_json, headers: {"Content-Type" => "application/json"}
        expect(user.password).to eq(update_password[:password])
      end
    end

    context "failed" do
      let (:user) {FactoryBot.create(:user)}
      let(:update_with_wrong_old_password) {{
        display_name: nil,
        email: nil,
        old_password: "BB#{user.password}AA",
        password: "AAAbbb111",
        password_confirmation: "AAAbbb111",
      }}

      it "doesn't update password if old_password is wrong" do
        sign_in_as(user.email, user.password)
        patch user_path(user.id), :params => update_with_wrong_old_password.to_json, headers: {"Content-Type" => "application/json"}
        expect(response).to have_http_status(400)
      end

      it "doesn't update if user doesn't have authorization" do
        sign_in_as(user.email, user.password)
        other_user = FactoryBot.create(:user)
        patch user_path(other_user.id), :params => update_with_wrong_old_password.to_json, headers: {"Content-Type" => "application/json"}

        expect(response).to have_http_status(401)
      end
    end
  end
end
