class TasksController < ApplicationController
    respond_to :json
    
    def index
        @project = Project.find_by(id: params['projectId'])
        render json: @project.tasks
    end
    
    def show
        @task = Task.find_by(id: params['id'])
        render json: {task: @task, comments: @task.comments.to_a}
    end
end