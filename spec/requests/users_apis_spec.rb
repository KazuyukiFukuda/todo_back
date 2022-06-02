require 'rails_helper'

RSpec.describe "UsersApis", type: :request do
  describe "POST /users" do
    context "successful" do
      user = FactoryBot.build(:user)

      it "returns sucsess with display name and email, password, password_confirmation" do
        sign_up(user)
        expect(response).to have_http_status(201)
        expect(response.body).to include(user.display_name)
        expect(session[:session_id]).to_not eq(nil)
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
        get "/users"
      end

      it "returns 200 status" do
        expect(response).to have_http_status(200)
      end

      it "returns all user list" do
        expect(JSON.parse(response.body).length).to eq(User.count)
      end

      it "has id and email, display name for each" do
        a_hash = JSON.load(response.body)[0]
        user = User.find_by(id: a_hash[:id])
        answer_hash = {id: user.id, email: user.email, display_name: user.display_name}
        expect(a_hash).to eq(answer_hash)
      end
    end

    context "fail" do
      it "can't get without login" do
        get "/users"
        expect(response).to have_http_status(401)
      end
    end
  end
end
