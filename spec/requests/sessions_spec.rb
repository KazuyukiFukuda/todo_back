require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /auth" do
    context "success" do
      it "returns http success " do
        user = FactoryBot.create(:user)
        post "/auth", params: {"email" => user.email, "password" => user.password}
        expect(response).to have_http_status(201)
        expect(response.body).to include(user.display_name)
      end
    end

    context "fail" do
      it "returns error message without email" do
        user = FactoryBot.create(:user, email: nil)
        sign_in_as(user)
        expect(response).to have_http_status(400)
        expect(response.body).to include("emailが入力されていません")
      end

      it "returns error message without password" do
        user = FactoryBot.create(:user, password: nil)
        sign_in_as(user)
        expect(response).to have_http_status(400)
        expect(response.body).to include("passwordが入力されていません")
      end

      it "returns error message if email doesn't exist" do
        user = FactoryBot.build(:user)
        sign_in_as(user)
        expect(response).to have_http_status(400)
        expect(response.body).to include("入力されたemailは存在しません")
      end

      it "returns error message if password does't match email" do
        user = FactoryBot.create(:user)
        user.password = "hoge#{user.password}"
        sign_in_as(user)
        expect(response.body).to include("emailまたはpasswordが間違っています")
      end
    end
  end

  describe "DELETE /auth" do
    it "log out successfuly" do
      user = FactoryBot.create(:user)
      sign_in_as(user)

      delete "/auth"
      expect(response).to have_http_status(401)
      expect(session[:session_id]).to eq nil
    end
  end
end
