Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'home/index'
    end
  end

  root to: "api/v1/home#index"
end
