require_dependency 'api_v1'

Flashvolunteer::Application.routes.draw do
    mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
    mount Api_v1::API => "/"

    devise_for :users, :module => "users"

    devise_scope :user do
        root :to => "users#index"
        put "confirm_account", :to => "users/confirmations#confirm_account"
        get "users/sign_up/quick", :to => "users/registrations#quick", :as => "quick_new_user"
        get "users/sign_up/third_party", :to => "users/registrations#third_party", :as => "third_party_sign_up"
        get "users/sign_in/third_party", :to => "users/sessions#third_party", :as => "third_party_sign_in"
        post "users/sign_in/:provider", :to => "users/sessions#mobile"
    end

    get "users/search", :to => "users#search"
    get "neighborhoods/search", :to => "neighborhoods#search"
    get "orgs/search", :to => "orgs#search"
    get "events/search", :to => "events#search"
    get "events/instructions", :to => "events#instructions"

    resources :afg_opportunities, :only => [:index] do 
        member do
            put :create_event
            put :hide_event
        end
        collection do 
            post :more
        end
    end

    resources :volunteer_match, :only => [:index] do
        member do
          put :create_event
          put :hide_event
        end
        collection do
            post :more
        end
    end

    resources :affiliates do
      resources :users, :only => [:create, :destroy], :controller => 'affiliates/users'
    end

    # 
    # Index - Show all users?
    # Show - Timeline
    # Edit - Change profile
    # Update - Actually updating it
    resources :users, :only => [:index, :show, :edit, :update] do
        member do
            # My events
            # past/upcoming/recommended
            resource :events, :only => [:show], :controller => "users/events", :as => "events_user"

            # Change privacy settings
            resource :privacy, :only => [:show, :update], :controller => "users/privacy", :as => "user_privacy_settings"

            # Change notification settings
            resource :notifications, :only => [:show, :update], :controller => "users/notifications", :as => "user_notification_settings"

            # Prop this user
            resources :props, :controller => "users/props" 


            delete :photo

            # Switch user login
            get :switch


            put "checkin/:event_id" => "users/checkin#create", :as => "checkin"
        end

        resources :followers, :only => [:update, :destroy], :controller => "users/followers"
        
        # 
        # Show - List organizations you're part of
        # Update - Remove?
        resources :orgs, :only => [:index, :update], :controller => "users/organizations"
    end

    resources :new_user_wizard, :only => [:show, :update], :controller => "users/new_user_wizard"
    resources :new_org_wizard, :only => [:show, :update], :controller => "orgs/new_org_wizard"
    root :to => "users#index"

    resources :neighborhoods, :only => [:index]

    # POST 
    resources :participations, :only => [:update, :destroy]

    resources :user_affiliations, :only => [:create, :destroy]

    #
    # Index - Show all orgs?
    # Show - Timeline
    # Edit - Change profile
    # Update - Actualy update profile
    resources :orgs do
        # Private parts, available to current signed-in org
        member do
            # Show organization past/upcoming events
            resource :events, :only => [:show], :controller => "orgs/events", :as => "events_org"

            # Show admins of the org
            resource :stats, :only => [:show], :controller => "orgs/stats", :as => "org_stats"
        end
        # Show admins of the org
        resources :users, :only => [:create, :index, :update, :destroy], :controller => "orgs/users"
        collection do
            post :register
        end
    end
   
    # Search for people
    resources :people, :only => [:index]

    resources :events do
        member do
            resource :register, :only => [:create, :destroy], :controller => "events/register", :as => "register_event"
            post :broadcast
            get :export
            get :print
            get :clone
        end
        collection do 
            get :featured
        end
    end
    match "events/in/:neighborhood/:city" => "events#in", :as => 'events_neighborhood', :via => :get
    match "events/this/:timeframe" => "events#this", :as => 'this_events', :via => :get

    post "search" => "search#show", :as => "search"

    match "privacy" => "home#privacy"
    match "tou" => "home#tou"
    match "jobs" => "home#jobs"
    match "about" => "home#about"
    match "partners" => "home#partners"
    match "help" => "help_articles#index", :as => "help_articles"
    match "donate" => "home#donate"
    match "newsletter" => "home#newsletter"
    match "sadface" => "home#sadface"
    match "error" => "home#error"
    match "leaderboard" => "neighborhoods#leaderboard"
    
end
