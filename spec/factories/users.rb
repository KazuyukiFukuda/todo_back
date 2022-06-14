FactoryBot.define do
  factory :user, aliases: [:owner] do
    email { Faker::Internet.email }
    password { "KdfgYd123fa" }
    password_confirmation {"KdfgYd123fa"}
    display_name { Faker::JapaneseMedia::DragonBall.character }

    trait :nil_user do
      email {nil}
      password {nil}
      password_confirmation {nil}
      display_name {nil}
    end

    factory :user_with_tasks do
      transient do
        task_count {3}
      end

      after(:create) do |user, evaluator|
        create_list(:task, evaluator.task_count, user_id: user.id, assignee_id: nil)
      end
    end

    factory :user_with_tasks_subtask do
      transient do
        task_count {3}
      end

      after(:create) do |user, evaluator|
        create_list(:task_with_subtasks, evaluator.task_count, user_id: user.id, assignee_id: nil)
      end
    end

  end
end
