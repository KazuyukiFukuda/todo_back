require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user1) {FactoryBot.create(:user)}
  let(:user2) {FactoryBot.create(:user)}

  describe "validation" do
    it "belong to user id " do
      belong_to(:user_id).class_name(User)
    end

    it "belong to assignee id" do
      belong_to(:assignee_id).class_name(User)
    end

    context "valid" do
      it 'is valid with name and description, deadline, completed, user_id, assignee_id, public' do
        task = FactoryBot.build(:task, user_id: user1.id, assignee_id: user2.id)
        expect(task).to be_valid
      end

      it "is valid without description" do
        task = FactoryBot.build(:task, user_id: user1.id, assignee_id: user2.id, description: nil)
        expect(task).to be_valid
      end

      it "id valid without deadlin" do
        task = FactoryBot.build(:task, user_id: user1.id, assignee_id: user2.id, deadline: nil)
        expect(task).to be_valid
      end

      it "is valid without assignee_id" do
        task = FactoryBot.build(:task, user_id: user1.id, assignee_id: nil)
        expect(task).to be_valid
      end
    end

    context "invalid" do
      it "is invalid without name" do
        task = FactoryBot.build(:task, user_id: user1.id, assignee_id: user2.id, name: nil)
        task.valid?
        expect(task.errors[:name]).to include("can't be blank")
      end

      it "is invalid without completed" do
        task = FactoryBot.build(:task, user_id: user1.id, assignee_id: user2.id, completed: nil)
        task.valid?
        expect(task.errors[:completed]).to include("is not included in the list")
      end

      it "is invalid without user id" do
        task = FactoryBot.build(:task, assignee_id: user2.id, user_id: nil)
        task.valid?
        expect(task.errors[:user_id]).to include("can't be blank")
      end

      it "is invalid without public" do
        task = FactoryBot.build(:task, user_id: user1.id, assignee_id: user2.id, public: nil)
        task.valid?
        expect(task.errors[:public]).to include("is not included in the list")
      end

      it "is invalid with past date for deadline" do
        task = FactoryBot.build(:task, user_id: user1.id, assignee_id: user2.id, deadline: 1.day.ago)
        expect(task).to_not be_valid
      end
    end
  end
end
