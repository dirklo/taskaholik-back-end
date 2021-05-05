class TeamsController < ApplicationController
    respond_to :json

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

    def create
        @user = User.find_by(id: team_params[:user_id])
        @team = Team.new(name: team_params[:name], leader: @user)
        if @team.save
            render json: {message: "Team successfully created", status: 200, team: @team}
        else
            render json: {message: 'Something went wrong!', status: 401}
        end
    end

    private
        def team_params
            params.require(:team).permit(:name, :user_id)
        end
end
