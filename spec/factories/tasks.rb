FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "MyString #{n}" }
    description { "MyText" }
    deadline { 1.week.from_now }
    completed { false }
    public { false }
    user_id { nil }
    assignee_id {nil}

    trait :deadline_yesterday do
      deadline { 1.day.ago }
    end
  end
end
