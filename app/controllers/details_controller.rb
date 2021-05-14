class DetailsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!

    def index
        @task = Task.find_by(id: params['taskId'])
        render json: @task.details
    end

    def show
        @detail = Detail.find_by(id: params['id'])
        if @detail
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
            render json: {detail: @detail, comments: @comments, assignees: @detail.assignees.to_a}, status: 200
        else
            render json: {message: 'Something went wrong!'}, status: 500
        end
    end

    def create
        @task = Task.find_by(id: params['task_id'])
        @detail = @task.details.new(detail_params)
        if @detail.save
            render json: {message: 'Added Successfully', detail: @detail}, status: 200
        else
            render json: {message: @detail.errors.full_messages[0]}, status: 500
        end
    end

    def update
        @detail = Detail.find_by(id: params[:id])
        if @detail.update(detail_params)
            render json: {detail: @detail, message: "detail updated"}, status: 200
        else
            render json: {message: @detail.errors.full_messages[0]}, status: 500
        end
    end

    def destroy
        @detail = Detail.find_by(id: params['id'])
        if current_user == @detail.creator || 
            current_user == @detail.task.project.team.leader 
            if @detail.destroy 
                render json: {message: 'Deleted Successfully'}, status: 200
            else
                render json: {message: 'Something went wrong!'}, status: 500
            end
        else
            render json: {message: 'You are not authorized to do that.'}, status: 500
        end

    end


    def complete 
        @detail = Detail.find_by(id: params['id'])       
        @detail.completed = !params['status']
        
        if @detail.save
            render json: {message: 'Detail Completed'}, status: 200
        else
            render json: {message: 'Something went wrong!'}, status: 500
        end
    end

    private
        def detail_params
            params.require(:detail).permit(:content, :creator_id, :task_id, :deadline)
        end
end