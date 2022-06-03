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
  end
end
