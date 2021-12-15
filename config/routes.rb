Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  resources :monthly_goals, only: [ :index, :create, :destroy, :update ] do
    resources :monthly_memos, only: [ :create, :destroy, :update ]
  end
end
