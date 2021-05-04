class DetailCommentsController < ApplicationController
    respond_to :json

    def index
        @detail = Detail.find_by(id: params['detail_id'])
        render json: @detail.comments
    end

    def create
        @comment = DetailComment.create(detail_comment_params)
        render json: {comment: @comment, author: @comment.author.username}
    end

    def destroy
        @detail_comment = DetailComment.find_by(id: params[:id])
        @user = User.find_by(id: detail_comment_params['user_id'])
        if @detail_comment.destroy
            render json: "Comment Successfully Deleted", status: 200
        else
            render json: "Something Went Wrong", status: 500
        end
    end

    private 
        def detail_comment_params
            params.require('detail_comment').permit(:detail_id, :content, :author_id, :user_id)
        end
end