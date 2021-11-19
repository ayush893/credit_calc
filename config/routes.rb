Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :credit_details, only: [:new, :create, :index] do
    collection do 
      get :your_detail
    end
  end
  root to: "credit_details#new"
end
