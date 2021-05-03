class DetailsController < ApplicationController
    respond_to :json

    def index
        @task = Task.find_by(id: params['taskId'])
        render json: @task.details
    end

    def show
        @detail = Detail.find_by(id: params['id'])
        @comments = @detail.comments.collect do |detail| 
            {
                author: detail.author.username,
                author_id: detail.author.id,
                content: detail.content,
                created_at: detail.created_at,
                detail_id: detail.detail_id,
                id: detail.id
            }
        end
        render json: {detail: @detail, comments: @comments}
    end

    def create
        @detail = Detail.new(content: params['content'], task_id: params['task_id'])
        if @detail.save
            render json: {message: 'Added Successfully', status: 200, detail: @detail}
        else
            render json: {message: 'Something Went Wrong!', status: 401}
        end
    end

    def destroy
        @detail = Detail.find_by(id: params['id'])
        if @detail.destroy 
            render json: {message: 'Deleted Successfully', status: 200}
        else
            render json: {message: 'Something went wrong!', status: 401}
        end
    end


    def complete 
        @detail = Detail.find_by(id: params['id'])       
        @detail.completed = true if params['status'] == 'complete'
        @detail.completed = false if params['status'] == 'incomplete'
        if @detail.save
            render json: {message: 'Detail Completed', status: 200}
        else
            render json: {message: 'Something went wrong!', status: 401}
        end
    end

end