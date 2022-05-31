FactoryBot.define do
  factory :user do
    email { hogehoge@example.com }
    password_digest { KdfgYd123fa }
    display_name { Kazu }
  end
end
