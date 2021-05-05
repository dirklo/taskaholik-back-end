class MembershipsController < ApplicationController
    respond_to :json

    def index
        @team = Team.find_by(id: params[:team_id])
        render json: @team.members.to_a
    end

    def create
        @user = User.find_by(username: membership_params[:query]) || 
                User.find_by(email: membership_params[:query])
        render json: {message: "No User Found!", status: 500} if !@user

        @team = Team.find_by(id: membership_params[:team_id])
        @membership = Membership.new(user: @user, team: @team, admin: false)
        if @membership.save
            render json: {message: 'Member successfully added', member: @user, status: 200}
        else
            render json: {message: 'Something went wrong!', status: 500}
        end
    end

    def destroy
        @membership = Membership.find_by(membership_params)
        if @membership.destroy
            render json: {message: 'Member successfully removed', status: 200}
        else
            render json: {message: 'Something went wrong!', status: 500}
        end
    end

    private
        def membership_params
            params.require(:membership).permit(:team_id, :user_id, :query)
        end
end