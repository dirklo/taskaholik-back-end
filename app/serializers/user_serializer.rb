class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :username, :selected_team, :selected_project, :selected_task, :selected_detail
end
