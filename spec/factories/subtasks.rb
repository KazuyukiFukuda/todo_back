FactoryBot.define do
  factory :subtask do
    task_id { nil }
    description { "MyString" }
    completed { false }
  end
end
