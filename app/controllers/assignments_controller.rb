class AssignmentsController < ApplicationController
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
            render json: {message: @assignment.errors.full_messages}, status: 500
        end
    end

    def destroy
        @assignment = Assignment.find_by(assignment_params)
        if @assignment.destroy
            render json: { message: 'Assignment successfully destroyed'}, status: 200
        else
            render json: { message: 'Something Went Wrong!'}, status: 500
        end
    end

    private
        def assignment_params
            params.require(:assignment).permit(:user_id, :detail_id)
        end
end