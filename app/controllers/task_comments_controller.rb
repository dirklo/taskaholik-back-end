class TaskCommentsController < ApplicationController
    respond_to :json

    def index
        @task = Task.find_by(id: params['taskId'])
        render json: @task.comments
    end

    def create
        @comment = TaskComment.create(task_comment_params)
        render json: {comment: @comment, author: @comment.author.username}
    end

    def destroy
        @task_comment = TaskComment.find_by(id: params[:id])
        @user = User.find_by(id: task_comment_params[:user_id])
        if @task_comment.destroy && @user == @task_comment.author
            render json: "Comment Successfully Deleted", status: 200
        else
            render json: "Something Went Wrong", status: 500
        end
    end

    private 
        def task_comment_params
            params.require('task_comment').permit(:task_id, :content, :author_id, :user_id)
        end
end