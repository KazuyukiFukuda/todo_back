require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    context "valid" do
      it "is valid with email ans password, display name" do
        
      end
    end

    context "invalid" do
      it "is invalid without email" do
        
      end

      it "is invalid without password" do
        
      end

      it "is invalid without display name" do
        
      end

      it "is invalid with password shorter than 8" do

      end

      it "is invalid with passwor that does'nt include large character" do
        
      end

      it "is invalid with passwor that does'nt include small character" do
        
      end

      it "is invalid with passwor that does'nt include number" do
        
      end

    end
  end
end
