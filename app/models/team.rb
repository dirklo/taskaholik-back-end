class Team < ApplicationRecord
    has_many :memberships
    has_many :members, through: :memberships, source: :user
    has_many :projects
    belongs_to :leader, class_name: "User"
end
