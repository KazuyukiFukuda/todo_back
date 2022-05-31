require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    it "has a valid factory" do
      expect(FactoryBot.build(:user)).to be_valid
    end

    context "valid" do
      it "is valid with email ans password, display name" do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end

      it "is valid without display name" do
        user = FactoryBot.build(:user, display_name: nil)
        expect(user).to be_valid
      end
    end

    context "invalid" do
      it "is invalid without email" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it "is invalid without password" do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it "is invalid when password and password confirmation are not same" do
        user = FactoryBot.build(:user, password: "KdfgYd123fa", password_confirmation: "KdfgYd123ea")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it "is invalid with password shorter than 8" do
        user = FactoryBot.build(:user, password: "hogehog", password_confirmation: "hogehog")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
        #expect(user).to_not be_valid  
      end

      it "is invalid with password that does'nt include large character" do
        user = FactoryBot.build(:user, password: "dfgyd123fa", password_confirmation: "dfgyd123fa")
        user.valid?
        expect(user.errors[:password]).to include("is invalid")
        #expect(user).to_not be_valid  
      end

      it "is invalid with password that does'nt include small character" do
        user = FactoryBot.build(:user, password: "ADF1AD23ADS", password_confirmation: "ADF1AD23ADS")
        user.valid?
        expect(user.errors[:password]).to include("is invalid")
        #expect(user).to_not be_valid  
      end

      it "is invalid with password that does'nt include number" do
        user = FactoryBot.build(:user, password: "ASDgadfgEWAR", password_confirmation: "ASDgadfgEWAR")
        user.valid?
        expect(user.errors[:password]).to include("is invalid")
        #expect(user).to_not be_valid  
      end

    end
  end
end
