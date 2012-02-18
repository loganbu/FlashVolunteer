Flashvolunteer::Application.routes.draw do


  devise_for :users, :controllers => { :confirmations => "users/confirmations", :registrations => "users/registrations", :sessions => "users/sessions", :passwords => "users/passwords" } do
		root :to => "users#index"
    put "confirm_account", :to => "users/confirmations#confirm_account"
		get "users/sign_up/quick", :to => "users/registrations#quick", :as => "quick_new_user"
  end
  
  resources :users, :only => [:index, :show, :edit, :update]

  root :to => "users#index"

  resources :neighborhoods, :only => [:index]

  resources :events do
		member do
			resource :register, :only => [:create, :destroy], :controller => "events/register", :as => "register_event"
			get :export
		end
	end
  match "events/in/:neighborhood" => "events#in", :as => 'events_neighborhood', :via => :get
  
  match "privacy" => "home#privacy"
  match "tou" => "home#tou"
  match "about" => "home#about"
  match "partners" => "home#partners"
  match "help" => "home#help"
  match "donate" => "home#donate"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
