class DetailsController < ApplicationController
    respond_to :json

    def index
        @task = Task.find_by(id: params['taskId'])
        result = []
        @task.details.each do |detail|
            result << { detail: detail, comments: detail.comments.to_a }
        end
        render json: result
    end
end