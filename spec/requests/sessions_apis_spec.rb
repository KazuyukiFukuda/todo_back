require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  user = FactoryBot.create(:user)

  describe "POST /auth" do
    context "success" do
      it "returns http success " do
        sign_in_as(user.email, user.password)
        expect(response).to have_http_status(201)
        expect(response.body).to include(user.display_name, user.id.to_s())
        expect(session[:user_id]).to_not eq(nil)
      end
    end

    context "fail" do
      not_saved_user = FactoryBot.build(:user)
      after do
        expect(response).to have_http_status(400)
        expect(response.body).to include("emailまたはpasswordが間違っています")
        expect(session[:user_id]).to eq(nil)
      end

      it "returns error message without email" do
        sign_in_as("", user.password)
      end

      it "returns error message without password" do
        sign_in_as(user.email, "")
      end

      it "returns error message if email doesn't exist" do
        sign_in_as(not_saved_user.email, not_saved_user.password)
      end

      it "returns error message if password does't match email" do
        sign_in_as(user.email, Faker::Internet.email)
      end
    end
  end

  describe "DELETE /auth" do
    it "log out successfuly" do
      sign_in_as(user.email, user.password)

      delete  '/auth'
      expect(response).to have_http_status(204)
      expect(session[:user_id]).to eq(nil)
    end

    it "doesn't logout when not login" do
      delete  '/auth'
      error_user_id = Digest::MD5.hexdigest("4")
      session[:user_id] = ""
      expect(response).to have_http_status(401)
    end
  end
end
