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

    factory :task_with_subtasks do
      transient do
          subtask_count {3}
      end

      after(:create) do |task, evaluator|
          create_list(:subtask, evaluator.subtask_count, task_id: task.id)
      end
  end

  end
end
