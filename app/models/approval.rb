class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :task, counter_cache: true

  validates :user_id, uniqueness: { scope: :task_id }
end
