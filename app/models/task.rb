class Task < ApplicationRecord
    has_many :details
    has_many :comments, class_name: "TaskComment"
    belongs_to :creator, class_name: "User"
    belongs_to :project
    has_many :prereq_tasks
    has_many :requirements, through: :prereq_tasks 

    def completed?
        result = true 
        details.each do |detail| 
            completed = false if !detail.completed
        end
        result
    end
end
