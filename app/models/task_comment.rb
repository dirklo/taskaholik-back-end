class TaskComment < ApplicationRecord
    belongs_to :author, class_name: "User"
    belongs_to :task
end
