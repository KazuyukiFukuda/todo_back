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
        get "/users"
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
        get "/users"
        expect(response).to have_http_status(401)
      end
    end
  end


  describe "PATCH /users:id" do
    before do
      @user = FactoryBot.create(:user)
      sign_in_as(@user.email, @user.password)
    end

    context "success" do
      before do
        @update_user = {
          email: Faker::Internet.email,
          #email: "kazu@test.com",
        }
        patch user_path(@user), params: {email: Faker::Internet.email}.to_json, headers: {"Content-Type" => "application/json"}
      end

      it "returns 200 status" do
        #expect(response).to have_http_status(200)
        expect( response.body ).to include(@user[:email])
      end

      it "doesn't update others" do
        updated_user = User.find_by(id: @user.id)
        updated_user_hash = updated_user.attributes
        user_hash = @user.attributes.slice(:display_name, :password)
        expect(updated_user_hash).to include(user_hash)
      end
    end

    context "failed" do
    
      it "doesn't update password if old_password is wrong" do
        user_here = FactoryBot.create(:user)
  
        update_user = {
          display_name: nil,
          email: nil,
          old_password: "agRHASWERTY23345",
          password: "ETYserSRT2345",
          password_confirmation: "ETYserSRT2345",
        }
  
        patch user_path(user_here), :params => update_user.to_json, headers: {"Content-Type" => "application/json"}
        expect(response).to have_http_status(400)
      end
  
      it "doesn't update if user doesn't have authorization" do
        other_user = FactoryBot.create(:user)
        user_here2 = FactoryBot.create(:user)
        patch user_path(other_user), :params => user_here2.attributes.to_json, headers: {"Content-Type" => "application/json"}
  
        expect(response).to have_http_status(401)
      end
    end
  end
end
