class Detail < ApplicationRecord
    belongs_to :task
    has_many :comments, class_name: "DetailComment"
end
