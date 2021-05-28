Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  resources :teams
  # post '/users/:id/set_current_team', to: 'users#set_current_team'
  # post '/users/:id/set_current_project', to: 'users#set_current_project'
  # post '/users/:id/set_current_task', to: 'users#set_current_task'
  # post '/users/:id/set_current_detail', to: 'users#set_current_detail'
  patch '/users/:id/set_selected', to: 'users#set_selected'
  resources :projects
  resources :tasks
  resources :details
  resources :memberships
  delete '/memberships', to: 'memberships#destroy'
  post '/details/:id/complete', to: 'details#complete' 
  resources :assignments
  delete '/assignments', to: 'assignments#destroy'
  resources :task_comments
  resources :detail_comments
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
