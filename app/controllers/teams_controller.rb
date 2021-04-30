class TeamsController < ApplicationController
    respond_to :json

    def index
        @user = User.find_by(id: params["userId"])
        render json: @user.led_teams.to_a.concat(@user.teams.to_a).to_json  
    end
end
