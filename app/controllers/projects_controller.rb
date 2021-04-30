class ProjectsController < ApplicationController
respond_to :json
    
    def index
        @team = Team.find_by(id: params['teamId']) 
        render json: @team.projects
    end
end