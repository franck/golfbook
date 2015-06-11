Rails.application.routes.draw do
  resources :members do
    member do
      put :follow
      put :unfollow
    end
  end
  root 'members#index'
end
