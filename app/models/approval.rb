class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :task, counter_cache: true
end
