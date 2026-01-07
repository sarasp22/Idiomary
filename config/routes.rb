Rails.application.routes.draw do
  scope "(:locale)", locale: /en|it|fr|es|pt/ do
    devise_for :users

    root 'home#index'

    get 'search', to: 'translations#search', as: 'search'
    post 'search', to: 'translations#search'

    post 'translations/save', to: 'translations#save', as: 'save_translation'

    get 'my_dictionary', to: 'translations#my_dictionary', as: 'my_dictionary'
    delete 'translations/:id', to: 'translations#destroy', as: 'delete_translation'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
