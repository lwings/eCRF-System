Rails.application.routes.draw do

  get 'welcome/new'
  get 'welcome/guide'

  scope "(:locale)", locale: /en|zh-CN/ do
    root to: "home#home"
  end



  devise_for :users, controllers: { sessions: 'users/sessions' }, skip: :registration
  devise_scope :user do
    resource :registration,
             only: [:edit, :update],
             path: 'users',
             controller: 'users/registrations',
             as: :user_registration do
      post 'avatar', on: :collection
    end
  end

  resources :users

  get '/project_login', to: 'projectsessions#new'
  post '/project_login', to: 'projectsessions#create'
  delete '/project_logout', to: 'projectsessions#destroy'
  get '/project_exception', to: 'projectsessions#exception'

end
