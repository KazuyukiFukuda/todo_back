class User < ApplicationRecord
    has_many :owned_tasks,      class_name: "Task", foreign_key: "user_id"
    has_many :assigned_tasks,   class_name: "Task", foreign_key: "assignee_id"
    accepts_nested_attributes_for :owned_tasks, :assigned_tasks, allow_destroy: true
    
    before_save {self.email = email.downcase}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum:255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensiteve: false}
    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])[!-~]+\z/
    has_secure_password
    validates :password, presence: true, length: {minimum:8}, format: {with: VALID_PASSWORD_REGEX}
end
