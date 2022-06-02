FactoryBot.define do
  factory :user, aliases: [:owner] do
    email { Faker::Internet.email }
    password { "KdfgYd123fa" }
    password_confirmation {"KdfgYd123fa"}
    display_name { Faker::JapaneseMedia::DragonBall.character }
  end
end
