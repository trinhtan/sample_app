Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get "users/new"
  root "static_pages#home"
  get "static_pages/home"
  get  "/help",    to: "static_pages#help", as: :help
  get  "/about",   to: "static_pages#about", as: :about
  get  "/contact", to: "static_pages#contact", as: :contact
  get  "/signup",  to: "users#new"
  get "/login", to: "session#new"
  post "/login", to: "session#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]

  scope "(:locale)", locale: /en|vi/ do
    root to: 'static_pages#home'
  end
  def default_url_options
    { locale: I18n.locale }
  end

end
