class TaskCommentsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!

    def index
        @task = Task.find_by(id: params['taskId'])
        render json: @task.comments.to_json(include: :author)
    end

    def create
        @comment = TaskComment.new(task_comment_params)
        @comment.author = current_user
        if @comment.save
            render json: @comment.to_json(include: :author), status: 200
        else
            render json: {message: @comment.errors.full_messages[0]}, status: 500
        end
    end

    def destroy
        @task_comment = TaskComment.find_by(id: params[:id])
        if current_user == @task_comment.author
            if @task_comment.destroy
                render json: {message: "Comment successfully deleted."}, status: 200
            else
                render json: {message: "Something Went Wrong, comment not deleted."}, status: 500
            end
        else
            render json: {message: "You are not authorized to do that."}, status: 500
        end
    end

    private 
        def task_comment_params
            params.require('task_comment').permit(:task_id, :content, :author_id, :user_id)
        end
end