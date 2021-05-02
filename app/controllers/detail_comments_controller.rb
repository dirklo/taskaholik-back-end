class DetailCommentsController < ApplicationController
    respond_to :json

    def index
        @detail = Detail.find_by(id: params['detail_id'])
        render json: @detail.comments
    end
end