class TaskSerializer
  include JSONAPI::Serializer

  attributes :title, :status, :approvals_count, :deadline_at, :completed_at, :canceled_at, :created_at
  attribute :creator do |task|
    task.creator.email
  end
end
