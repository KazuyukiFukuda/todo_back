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
        stories_count {3}
      end

      after(:create) do |user, evaluator|
        create_list(:task, evaluator.stories_count, user_id: user.id, assignee_id: nil)
      end
    end
  end
end
