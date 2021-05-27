class TeamsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!, only: [:update]

    def index
        @user = User.find_by(id: params["userId"])
        @teams = @user.led_teams.to_a.concat(@user.teams.to_a)
        @teams = @teams.collect do |team|
            @members = team.members.collect do |member| 
                {
                    id: member.id, 
                    username: member.username, 
                    email: member.email
                }
            end
            {
                id: team.id, 
                name: team.name, 
                leader: team.leader,
                leader_id: team.leader_id ,
                members: @members
            }
        end
        render json: @teams
    end

    def show 
        @team = Team.find_by(id: params[:id])
        @members = @team.members
        @projects = @team.projects
        @tasks = @team.tasks
        @details = @team.details
        render json: {members: @members, projects: @projects, tasks: @tasks, details: @details}
    end

    def create
        @user = User.find_by(id: team_params[:user_id])
        @team = Team.new(name: team_params[:name], leader: @user)
        if @team.save
            render json: {message: "Team successfully created", status: 200, team: @team}
        else
            render json: {message: 'Something went wrong!', status: 401}
        end
    end

    def update
        @team = Team.find_by(id: params[:id])
        if @team.update(team_params)
            render json: {team: @team, message: "team updated"}, status: 200
        else
            render json: {message: @team.errors.full_messages[0]}, status: 500
        end
    end

    private
        def team_params
            params.require(:team).permit(:name, :user_id)
        end 
end
