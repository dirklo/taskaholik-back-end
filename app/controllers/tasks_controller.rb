class TasksController < ApplicationController
    respond_to :json
    before_action :authenticate_user!
    
    def index
        @project = Project.find_by(id: params['projectId'])
        render json: @project.tasks
    end
    
    def show
        @task = Task.find_by(id: params['id'])
        if @task
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
            render json: {task: @task, comments: @comments}, status: 200
        else
            render json: {message: 'Something went wrong!'}, status: 500
        end
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

    def destroy
        @task = Task.find_by(id: params[:id])
        if current_user == @task.creator || current_user == @task.project.team.leader
            if @task.destroy
                render json: {message: 'Successfully Deleted'}, status: 200
            else
                render json: {message: 'Something Went Wrong!'}, status: 500
            end
        else
            render json: {message: 'You are not authorized to do that'}, status: 500
        end
    end
end