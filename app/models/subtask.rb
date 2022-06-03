class Subtask < ApplicationRecord
  belongs_to :task

  validates :description, presence: true
  validates :completed, inclusion: {in: [true, false]}
end
