class Team < ApplicationRecord
    has_many :memberships
    has_many :members, through: :memberships, source: :user
    has_many :projects
    has_many :tasks, through: :projects
    has_many :details, through: :tasks
    belongs_to :leader, class_name: "User"
end
