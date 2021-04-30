class DetailsController < ApplicationController
    respond_to :json

    def index
        @task = Task.find_by(id: params['taskId'])
        result = []
        @task.details.each do |detail|
            @comments = detail.comments.collect do |comment| 
                {
                    author: comment.author.username,
                    content: comment.content,
                    created_at: comment.created_at,
                    detail_id: comment.detail_id
                }
            end
            result << { detail: detail, comments: @comments.to_a }
        end
        render json: result
    end
end