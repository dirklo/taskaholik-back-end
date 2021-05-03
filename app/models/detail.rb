class Detail < ApplicationRecord
    belongs_to :task
    has_many :comments, class_name: "DetailComment"
    belongs_to :creator, class_name: "User"
end
