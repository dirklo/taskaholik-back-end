class DetailCommentsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!

    def index
        @detail = Detail.find_by(id: params['detail_id'])
        render json: @detail.comments.to_json(include: :author)
    end

    def create
        @comment = DetailComment.new(detail_comment_params)
        @comment.author = current_user
        if @comment.save
            render json: @comment.to_json(include: :author), status: 200
        else
            render json: {message: @comment.errors.full_messages[0]}, status: 500
        end
    end

    def destroy
        @detail_comment = DetailComment.find_by(id: params[:id])
        if @detail_comment.destroy
            render json: {message: "Comment successfully deleted"}, status: 200
        else
            render json: {message: "Something went wrong. Comment not deleted."}, status: 500
        end
    end

    private 
        def detail_comment_params
            params.require('detail_comment').permit(:detail_id, :content, :author_id, :user_id)
        end
end