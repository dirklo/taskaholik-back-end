class UsersController < ApplicationController 
    before_action :authenticate_user!
    respond_to :json

    def set_selected
        @user = User.find_by(id: params[:id])
        @user.selected_team = params[:selected_team]
        @user.selected_project = params[:selected_project]
        @user.selected_task = params[:selected_task]
        @user.selected_detail = params[:selected_detail]
        if @user.save
            render json: {message: "current selections set"}, status: 200
        else
            render json: {message: "something went wrong"}, status: 500
        end
    end
end
