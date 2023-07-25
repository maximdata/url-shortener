Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :urls, only: [] do
        collection do
          post "encode"
          post "decode"
        end
      end
    end
  end
end
