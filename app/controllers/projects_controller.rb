class ProjectsController < ApplicationController
respond_to :json
    
    def index
        @team = Team.find_by(id: params['teamId']) 
        render json: @team.projects
    end

    def create
        @project = Project.new(project_params)
        if @project.save
            render json: {message: 'Project successfully saved', status: 200, project: @project}
        else
            render json: {message: 'Something went wrong!', status: 500}
        end
        
    end

    private
        def project_params
            params.require(:project).permit(:title, :creator_id, :team_id)
        end
end