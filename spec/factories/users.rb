FactoryBot.define do
  factory :user do
    email { "hogehoge@example.com" }
    password { "KdfgYd123fa" }
    password_confirmation {"KdfgYd123fa"}
    display_name { "Kazu" }
  end
end
