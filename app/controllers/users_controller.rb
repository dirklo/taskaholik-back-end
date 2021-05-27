class UsersController < ApplicationController 
    before_action :authenticate_user!
    respond_to :json

    def set_current_team
        @user = User.find_by(id: params[:id])
        @user.selected_team = params[:team_id]
        if @user.save
            render json: {message: "current team set"}, status: 200
        else
            render json: {message: "something went wrong"}, status: 500
        end
    end

    def set_current_project
        @user = User.find_by(id: params[:id])
        @user.selected_project = params[:project_id]
        if @user.save
            render json: {message: "current project set"}, status: 200
        else
            render json: {message: "something went wrong"}, status: 500
        end
    end
    
    def set_current_task
        @user = User.find_by(id: params[:id])
        @user.selected_task = params[:task_id]

        if @user.save
            render json: {message: "current task set"}, status: 200
        else
            render json: {message: "something went wrong"}, status: 500
        end
    end

    def set_current_detail
        @user = User.find_by(id: params[:id])
        @user.selected_detail = params[:detail_id]
        if @user.save
            render json: {message: "current detail set"}, status: 200
        else
            render json: {message: "something went wrong"}, status: 500
        end
    end
end
