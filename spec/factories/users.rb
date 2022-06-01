FactoryBot.define do
  factory :user, aliases: [:owner] do
    sequence(:email) { |n| "hogehog#{n}@example.com" }
    password { "KdfgYd123fa" }
    password_confirmation {"KdfgYd123fa"}
    display_name { "Kazu" }
  end
end
