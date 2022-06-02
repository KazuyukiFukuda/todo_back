require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    context "successful" do
      it "returns sucsess with display name and email, password, password_confirmation" do
        sign_up("hogehoge", "hogehoge@example.com", "FadsfYHd", "FadsfYHd")
        expect(response).to have_http_status(201)
        expect(response).to include("hogehoge")

        user = User.find_by(email:"hogehoge@example.com")
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "failed" do
      it "retursn fail" do
        sign_up("hogehoge", "hogehoge@example.com", nil, nil)
        expect(response).to have_http_status(400)
      end
    end
  end
end
