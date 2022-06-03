FactoryBot.define do
  factory :subtask do
    association :task
    description { "MyString" }
    completed { false }
  end
end
