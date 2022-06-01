require 'rails_helper'

RSpec.describe Subtask, type: :model do
  let(:user1) {FactoryBot.create(:user)}
  let(:user2) {FactoryBot.create(:user)}
  let(:task1) {FactoryBot.create(:task, user_id: user1.id, assignee_id: user2.id)}

  it "belongs to task" do
    belong_to(:task_id).class_name(Task)
  end

  describe "validation" do
    context "valid" do
      it "is valid with task id and description, model" do
        subtask = FactoryBot.build
      end
    end

    context "incalid" do
      it "is invalid withoud description" do

      end

      it "is invalid without mode" do
        
      end
    end
    
  end
  
end
