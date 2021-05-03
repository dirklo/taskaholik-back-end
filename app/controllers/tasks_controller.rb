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

    def create
        @project = Project.find_by(id: params['project_id'])
        @task = @project.tasks.new(title: params['title'], creator_id: params['creator_id'])

        if @task.save
            render json: {message: 'Added Successfully', status: 200, task: @task}
        else
            render json: {message: 'Something Went Wrong!', status: 401}
        end
    end
end