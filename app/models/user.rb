class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :created_tasks, class_name: 'Task', foreign_key: 'creator_id', dependent: :destroy
end
