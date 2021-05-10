class User < ApplicationRecord
  has_many :created_projects, class_name: "Project", foreign_key: "creator_id"
  has_many :led_teams, class_name: "Team", foreign_key: "leader_id"
  has_many :memberships
  has_many :teams, through: :memberships
  has_many :task_comments, foreign_key: "author_id"
  has_many :detail_comments, foreign_key: "author_id"
  has_many :assignments
  has_many :assigned_details, through: :assignments, source: :task

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end