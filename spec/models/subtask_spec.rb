require 'rails_helper'

RSpec.describe Subtask, type: :model do
  it "belongs to task" do
    belong_to(:task_id).class_name(Task)
  end

  describe "validation" do
    context "valid" do
      it "is valid with task id and description, model" do
        subtask = FactoryBot.create(:subtask)
        expect(subtask).to be_valid
      end
    end

    context "incalid" do
      it "is invalid withoud description" do
        subtask = FactoryBot.build(:subtask, description: nil)
        subtask.valid?
        expect(subtask.errors[:description]).to include("can't be blank")
        #expect(subtask).to_not be_valid
      end

      it "is invalid without mode" do
        subtask = FactoryBot.build(:subtask, completed: nil)
        subtask.valid?
        expect(subtask.errors[:completed]).to include("is not included in the list")
      end
    end
  end
end
