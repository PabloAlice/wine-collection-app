Rails.application.routes.draw do
  resources :cellars do
    resources :wines
  end
end