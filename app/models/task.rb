class Task < ApplicationRecord
  include AASM

  STATUSES = %w[new in_progress completed canceled].freeze
  FIELDS_FOR_BOARD = %i[id title status approvals_count creator_id].freeze

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id', required: true
  has_many :approvals, dependent: :destroy

  validates :title, presence: true

  scope :board_fields, -> { select(FIELDS_FOR_BOARD) }
  scope :ordered, -> { order(updaed_at: :desc) }
  scope :statused, -> (status) { where(status: status) }

  aasm whiny_transitions: false, column: :status do
    state :new, initial: true
    state :in_progress
    state :completed
    state :canceled

    event :start do
      transitions from: :new, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed, after: :set_completed_at
    end

    event :cancel do
      transitions from: :in_progress, to: :canceled, after: :set_canceled_at
    end
  end

  private

  def set_completed_at
    update(completed_at: Time.current)
  end

  def set_canceled_at
    update(canceled_at: Time.current)
  end
end
