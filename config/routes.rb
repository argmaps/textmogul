Rails.application.routes.draw do

  resources :admins
  resources :plans
  resources :subscriptions
  resources :subscribers

  root 'pages#show', id: 'home'

  get "/signin" => "sessions#new", :as => :sign_in
  get "/signout" => "sessions#destroy", :as => :sign_out
  get "/signup" => "accounts#new", :as => :sign_up
  post "/signup" => "accounts#create", :as => :create_account
  get "/settings" => "users#edit", :as => :settings

  resources :accounts, only: [:update]

  resources :sessions, only: [:new, :create, :destroy] do
    get 'session.js', on: :collection, action: :js_session, as: :js
  end

  resources :password_resets, except: [:destroy]

  resources :users, only: [:create, :edit, :update]

  resources :broadcasts

  controller :contact do
    get :contact, action: :new
    post :contact, action: :create, as: :make_contact
  end

  mount MailPreview => 'mail_view' if Rails.env.development?

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
