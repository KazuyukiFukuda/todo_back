FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "MyString #{n}" }
    description { "MyText" }
    deadline { 1.week.from_now }
    completed { false }
    public { false }
    association :user
    association :assignee, factory: :user

    trait :deadline_yesterday do
      deadline { 1.day.ago }
    end
  end
end
