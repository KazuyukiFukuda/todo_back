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
        user = FactoryBot.build(:user, password_digest: nil)
        user.valid?
        expect(user.errors[:password_digest]).to include("can't be blank")
      end

      it "is invalid with password shorter than 8" do
        user = FactoryBot.build(:user, password_digest: "hogehog")
        user.valid?
        expect(user.errors[:password_digest]).to include("can't be shorter than 8")
      end

      it "is invalid with passwor that does'nt include large character" do
        user = FactoryBot.build(:user, password_digest: "dfgyd123fa")
        user.valid?
        expect(user.errors[:password_digest]).to include("invalid password")
      end

      it "is invalid with passwor that does'nt include small character" do
        user = FactoryBot.build(:user, password_digest: "ADF1ADf23ADS")
        user.valid?
        expect(user.errors[:password_digest]).to include("invalid password")
      end

      it "is invalid with passwor that does'nt include number" do
        user = FactoryBot.build(:user, password_digest: "ASDgadfgEWAR")
        user.valid?
        expect(user.errors[:password_digest]).to include("invalid password")
      end

    end
  end
end
