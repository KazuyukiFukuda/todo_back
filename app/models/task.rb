class Task < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    belongs_to :assignee, class_name: "User", foreign_key: "assignee_id", optional: true

    validates :name, presence: true
    validate  :deadline_check
    validates :user_id, presence: true
    validates :completed, inclusion: {in: [true, false]}
    validates :public, inclusion: {in: [true, false]}

    def deadline_check
        if self.deadline != nil then
            errors.add("締め切りは過去に設定できません") unless Date.today < self.deadline
        end
    end
end
