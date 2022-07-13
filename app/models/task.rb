class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id', required: true
  has_many :approvals, dependent: :destroy

  validates :title, presence: true
end
