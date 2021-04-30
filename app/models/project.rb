class Project < ApplicationRecord
    belongs_to :creator, :class_name => "User"
    belongs_to :team
    has_many :tasks
end
