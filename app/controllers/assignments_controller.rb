class AssignmentsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @detail = Detail.find_by(id: params[:detail_id])
        @assignees = @detail.assignments.map do |assignment| 
            assignment.user
        end 
        render json: @assignees, status: 200
    end 

    def create
        if !Assignment.find_by(assignment_params)
            @assignment = Assignment.new(assignment_params)
            if @assignment.save
                render json: {message: 'Assignemnt created', member: @assignment.user}, status: 200
            else
                render json: {message: @assignment.errors.full_messages}, status: 500
            end
        else
            @assignment.errors.add(assignment: 'Assignment Already Exists')
            render json: {message: @assignment.errors.full_messages[0]}, status: 500
        end
    end

    def destroy
        @assignment = Assignment.find_by(assignment_params)
        if current_user == @assignment.detail.creator ||
            current_user == @assignment.detail.task.project.team.leader
            if @assignment.destroy 
                render json: { message: 'Assignment successfully destroyed'}, status: 200
            else
                render json: { message: 'Something Went Wrong!'}, status: 500
            end
        else
            render json: { message: 'You are not authorized to do that.'}, status: 500
        end
    end

    private
        def assignment_params
            params.require(:assignment).permit(:user_id, :detail_id)
        end
end