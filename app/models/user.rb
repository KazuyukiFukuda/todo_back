class User < ApplicationRecord
    has_many :tasks, foreign_key: "user_id", primary_key: "id"
    has_many :tasks, foreign_key: "assignee_id", primary_key: "id"
    
    before_save {self.email = email.downcase}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum:255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensiteve: false}
    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])[!-~]+\z/
    has_secure_password
    validates :password, presence: true, length: {minimum:8}, format: {with: VALID_PASSWORD_REGEX}
end
