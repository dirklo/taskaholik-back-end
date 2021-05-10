class Detail < ApplicationRecord
    belongs_to :task
    has_many :comments, class_name: "DetailComment"
    belongs_to :creator, class_name: "User"
    has_many :assignments
    has_many :assignees, through: :assignments, source: :user
end
