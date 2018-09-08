Rails.application.routes.draw do
  get 'users/new'
  root "static_pages#home"
  get "/help", to: "static_pages#help", as: :help
  get "/about", to: "static_pages#about", as: :about
  get "/contact", to: "static_pages#contact", as: :contact
  get "/signup", to: "users#new"
  get "/signup", to: 'users#create'
  resources :users
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
  end
  def default_url_options
    { locale: I18n.locale }
  end

end
