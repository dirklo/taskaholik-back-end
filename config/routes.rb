Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  resources :teams
  resources :projects
  resources :tasks
  resources :details
  resources :memberships
  delete '/memberships', to: 'memberships#destroy'
  post '/details/:id/complete', to: 'details#complete' 
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
