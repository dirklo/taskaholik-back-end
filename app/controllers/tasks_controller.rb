class TasksController < ApplicationController
    respond_to :json
    
    def index
        @project = Project.find_by(id: params['projectId'])
        render json: @project.tasks
    end
    
    def show
        @task = Task.find_by(id: params['id'])
        @comments = @task.comments.collect do |comment| 
            {
                author: comment.author.username,
                author_id: comment.author.id,
                content: comment.content,
                created_at: comment.created_at,
                task_id: comment.task_id,
                id: comment.id
            }
        end
        render json: {task: @task, comments: @comments}
    end
end