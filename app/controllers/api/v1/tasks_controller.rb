module Api
  module V1
    class TasksController < ActionController::API
      include Pagy::Backend

      before_action :validate_params
      after_action { pagy_headers_merge(@pagy) if @pagy }

      def index
        @pagy, @tasks = pagy(Task.includes(:creator).statused(params[:status]).ordered)

        render json: TaskSerializer.new(@tasks)
      end

      private

      def validate_params
        return if Task::STATUSES.include?(params[:status])

        render json: { errors: "There is no such status '#{params[:status]}'" }, status: :unprocessable_entity
      end
    end
  end
end
