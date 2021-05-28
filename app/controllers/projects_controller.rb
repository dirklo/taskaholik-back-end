class ProjectsController < ApplicationController
    respond_to :json
    
    def index
        @team = Team.find_by(id: params['teamId']) 
        render json: @team.projects
    end

    def create
        @project = Project.new(project_params)
        @user = User.find_by(id: project_params[:creator_id])
        if @project.save
            @user.selected_project = @project.id
            @user.save
            render json: {message: 'Project successfully saved', project: @project}, status: 200
        else
            render json: {message: @project.errors.full_messages[0]}, status: 500
        end 
    end

    def destroy
        @project = Project.find_by(id: params[:id])
        if current_user == @project.team.leader || current_user == @project.creator
            if @project.destroy
                render json: {message: 'Project successfully deleted'}, status: 200
            else
                render json: {message: @project.errors.full_messages[0]}, status: 500
            end
        else
            render json: {message: 'You are not authorized to do that.'}, status: 500
        end
    end

    private
        def project_params
            params.require(:project).permit(:title, :creator_id, :team_id, :deadline, :user_id)
        end
end