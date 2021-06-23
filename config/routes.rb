Rails.application.routes.draw do
  root 'homes#index'

  resources :homes do 
    collection do 
      get :pending_invitations
    end
    member do 
      get :friends
      get :profile
      post :send_request
      post :accept_request
    end
  end

  devise_for :users, path: :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
end


