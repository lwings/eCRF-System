Rails.application.routes.draw do

  get 'welcome/new'
  get 'welcome/guide'

  scope "(:locale)", locale: /en|zh-CN/ do
    root to: "welcome#guide"
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

  get '/infringement', to: 'infringements#index'

  resources :patients do
    collection do

    end
    resource :clinical_pathology
    resource :basement_assessment
    resource :reserach_completion
    resource :medication_completion
    resource :group_information
    resource :death_record
    resource :followup_monitor
    resource :course_monitor
    resources :radiation_therapies
    resources :courses
    resources :adverse_events
    resources :concomitant_drugs
    resources :biological_sample_collections
    resources :followups
  end

  resources :projects
  resources :research_groups
  resources :roles
  resources :centers

end
