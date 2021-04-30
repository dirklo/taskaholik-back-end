class PrereqTask < ApplicationRecord
    belongs_to :task
    belongs_to :requirement, class_name: "Task"
end
