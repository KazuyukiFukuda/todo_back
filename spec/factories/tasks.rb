FactoryBot.define do
  factory :task do
    name { "MyString" }
    description { "MyText" }
    deadline { "2022-05-31" }
    completed { false }
    user_id { 1 }
    assignee_id { 1 }
    public { false }
  end
end
