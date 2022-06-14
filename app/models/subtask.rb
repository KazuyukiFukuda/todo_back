class Subtask < ApplicationRecord
  belongs_to :task, foreign_key: "task_id", optional: true
  accepts_nested_attributes_for :task, allow_destroy: true

  validates :description, presence: true
  validates :completed, inclusion: {in: [true, false]}
end
