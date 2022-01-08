Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  resources :monthly_goals, only: [ :index, :create, :destroy, :update ] do
    resources :monthly_memos, only: [ :create, :destroy, :update ]
  end
  resources :weekly_goals, only: [ :index, :create, :destroy, :update ] do
    resources :weekly_memos,  only: [ :create, :destroy, :update ]
    resources :to_dos,        only: [ :create, :destroy, :update ] do
      patch "/flag", to: "to_dos#update_flag" #完了フラグの更新
    end
    # resources :tags, only: [ :create ]
  end
  resources :tags, only: [ :index, :create, :destroy, :update ]


end
