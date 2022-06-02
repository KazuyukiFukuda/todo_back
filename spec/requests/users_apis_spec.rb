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
end
