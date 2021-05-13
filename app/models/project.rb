class Project < ApplicationRecord
    belongs_to :creator, :class_name => "User"
    belongs_to :team
    has_many :tasks
    before_destroy :asset_cleanup

    def asset_cleanup 
        self.tasks.each do |task|
            task.details.each do |detail|
                detail.comments.destroy_all
            end
            task.details.destroy_all
            task.comments.destroy_all
        end
        self.tasks.destroy_all
    end
end
