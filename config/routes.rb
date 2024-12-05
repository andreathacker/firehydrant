Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :clues

  get "incidents/:incident_id/clues", to: "incidents_clues#index"
end
